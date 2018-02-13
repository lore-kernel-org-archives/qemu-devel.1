Received: from eggs.gnu.org ([2001:4830:134:3::10]:35665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eleQn-0008W8-Oa
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eleQj-0001jM-Pb
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:31:49 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:57219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eleQj-0001iX-FE
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:31:45 -0500
References: <20180206164815.10084-1-alex.bennee@linaro.org>
	<CAFEAcA9ZVrXbzTHHjMRpEadBjFLecgxwKvsN4gtWuR0NMP5xWQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <579a7106-ecdb-984e-97b5-bd23d0625156@vivier.eu>
Date: Tue, 13 Feb 2018 18:31:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ZVrXbzTHHjMRpEadBjFLecgxwKvsN4gtWuR0NMP5xWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 00/22] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>

Le 13/02/2018 à 16:51, Peter Maydell a écrit :
> On 6 February 2018 at 16:47, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Hi,
>>
>> The main change is applying the __attribute__((flatten)) to some of
>> the public functions that show up in Emilio's dbt-benchmark. This
>> seems to be a cleaner solution that squashing inlines higher up the
>> chain and still leaves the chance for re-use for the less widely used
>> functions. The results are an improvement over v3 by some margin:
>>
>>                          NBench score; higher is better
>>
>>     5 +-+-----------+-------------+------------+-------------+-----------+-+
>>       |                     ****### %%%%  +++                              |
>>   4.5 +-+...................*..*..#.%..%..****##..%%%%+ system-2.5       +-+
>>       |                     *  *  # %  %  *  * #  %  %      master         |
>>     4 +-+...................*..*..#.%..%..*..*.#..%..%softfloat-v3       +-+
>>   3.5 +-+...................*..*..#.%..%..*..*.#..%..%softfloat-%%%%.....+-+
>>       |                     *  *  # %  %  *  * #  %  %  * *  #  %  %       |
>>     3 +-+...................*..*..#.%..%..*..*.#..%..%..*.*..#..%..%.....+-+
>>       |                     *  *  #+%  %  *  * #$$$  %  * *  #  %  %       |
>>   2.5 +-+........####.......*..*..#$$..%..*..*.#..$..%..*.*..#..%..%.....+-+
>>       |       ****  #  %%%  *  *  # $  %  *  * #  $  %  * *  #$$$  %       |
>>     2 +-+.....*..*..#..%.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....+-+
>>       |       *  *  #  % %  *  *  # $  %  *  * #  $  %  * *  #  $  %       |
>>   1.5 +-+.....*..*..#$$$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....+-+
>>     1 +-+.....*..*..#..$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....+-+
>>       |       *  *  #  $ %  *  *  # $  %  *  * #  $  %  * *  #  $  %       |
>>   0.5 +-+.....*..*..#..$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....+-+
>>       |       *  *  #  $ %  *  *  # $  %  *  * #  $  %  * *  #  $  %       |
>>     0 +-+-----****###$$$%%--****###$$%%%--****##$$$%%%--***###$$$%%%-----+-+
>>                  FOURIER     NEURAL NETLU DECOMPOSITION    gmean
>>
>> Slightly easier to read PNG:
>>
>>     https://i.imgur.com/XEeL0bC.png
>>
>> I think it's pretty ready for a merge. Shall I submit a pull myself or
>> does it make sense going via someone else? According to MAINTAINERS
>> Peter and Aurelien are responsible for this code...
> 
> I had some nits but I think the best thing to do is if you fix those
> and then just send a pull request for this.

Just to be sure no one has missed that:

https://bellard.org/libbf/

I'm wondering if it can help for this work.

Thanks,
Laurent
