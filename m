Received: from eggs.gnu.org ([2001:4830:134:3::10]:57645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elcry-0003OR-3X
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elcrx-0005iR-6W
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:51:46 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:45384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elcrw-0005hs-Si
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:51:45 -0500
Received: by mail-oi0-x22f.google.com with SMTP id 23so2125013oip.12
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:51:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206164815.10084-1-alex.bennee@linaro.org>
References: <20180206164815.10084-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 15:51:23 +0000
Message-ID: <CAFEAcA9ZVrXbzTHHjMRpEadBjFLecgxwKvsN4gtWuR0NMP5xWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>

On 6 February 2018 at 16:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Hi,
>
> The main change is applying the __attribute__((flatten)) to some of
> the public functions that show up in Emilio's dbt-benchmark. This
> seems to be a cleaner solution that squashing inlines higher up the
> chain and still leaves the chance for re-use for the less widely used
> functions. The results are an improvement over v3 by some margin:
>
>                          NBench score; higher is better
>
>     5 +-+-----------+-------------+------------+-------------+-----------=
+-+
>       |                     ****### %%%%  +++                            =
  |
>   4.5 +-+...................*..*..#.%..%..****##..%%%%+ system-2.5       =
+-+
>       |                     *  *  # %  %  *  * #  %  %      master       =
  |
>     4 +-+...................*..*..#.%..%..*..*.#..%..%softfloat-v3       =
+-+
>   3.5 +-+...................*..*..#.%..%..*..*.#..%..%softfloat-%%%%.....=
+-+
>       |                     *  *  # %  %  *  * #  %  %  * *  #  %  %     =
  |
>     3 +-+...................*..*..#.%..%..*..*.#..%..%..*.*..#..%..%.....=
+-+
>       |                     *  *  #+%  %  *  * #$$$  %  * *  #  %  %     =
  |
>   2.5 +-+........####.......*..*..#$$..%..*..*.#..$..%..*.*..#..%..%.....=
+-+
>       |       ****  #  %%%  *  *  # $  %  *  * #  $  %  * *  #$$$  %     =
  |
>     2 +-+.....*..*..#..%.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....=
+-+
>       |       *  *  #  % %  *  *  # $  %  *  * #  $  %  * *  #  $  %     =
  |
>   1.5 +-+.....*..*..#$$$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....=
+-+
>     1 +-+.....*..*..#..$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....=
+-+
>       |       *  *  #  $ %  *  *  # $  %  *  * #  $  %  * *  #  $  %     =
  |
>   0.5 +-+.....*..*..#..$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....=
+-+
>       |       *  *  #  $ %  *  *  # $  %  *  * #  $  %  * *  #  $  %     =
  |
>     0 +-+-----****###$$$%%--****###$$%%%--****##$$$%%%--***###$$$%%%-----=
+-+
>                  FOURIER     NEURAL NETLU DECOMPOSITION    gmean
>
> Slightly easier to read PNG:
>
>     https://i.imgur.com/XEeL0bC.png
>
> I think it's pretty ready for a merge. Shall I submit a pull myself or
> does it make sense going via someone else? According to MAINTAINERS
> Peter and Aurelien are responsible for this code...

I had some nits but I think the best thing to do is if you fix those
and then just send a pull request for this.

thanks
-- PMM
