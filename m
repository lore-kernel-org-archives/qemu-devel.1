Received: from eggs.gnu.org ([2001:4830:134:3::10]:60815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dsUwl-0006dH-6Z
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dsUwi-0001O3-08
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:16:51 -0400
Received: from bran.ispras.ru ([83.149.199.196]:35173 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dsUwh-0001Nb-OG
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:16:47 -0400
Message-ID: <59BA8F4E.6060600@ispras.ru>
Date: Thu, 14 Sep 2017 17:16:46 +0300
From: Sergey Smolov <smolov@ispras.ru>
MIME-Version: 1.0
References: <59B7EBC5.9060908@ispras.ru>
	<CAFEAcA-to=vWWBHoxZRX-ExcbDe0OTMwpHunE7HXaYA0GE+ccw@mail.gmail.com>
	<59B7F503.8010703@ispras.ru>
	<CAFEAcA97i97_aoq8xNKtP8Z+i-u5Hq+_e6N80=T=WspSEW+A7A@mail.gmail.com>
	<59B8DE5A.9000301@ispras.ru>
	<CAFEAcA8UTVr-jO4Eh=uaUokYBhF0EYTuBoXdLyrKZ=GrjPFtmQ@mail.gmail.com>
	<0c3db1e3-1638-cfbe-8c97-0d1aa87547b0@imgtec.com>
	<59BA88D1.9080202@ispras.ru>
	<CAFEAcA_HRwa_XFv8M3h_5dK0p6Xiuu1FfF32TPOhEop80wT30A@mail.gmail.com>
In-Reply-To: <CAFEAcA_HRwa_XFv8M3h_5dK0p6Xiuu1FfF32TPOhEop80wT30A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] MIPS 'move' insn emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, QEMU Developers <qemu-devel@nongnu.org>


On 14.09.2017 16:58, Peter Maydell wrote:
> At translate time it is generating some extra code which at runtime
> will call the helper_trace_reg_access() function, passing it the
> values in the registers at this point. This will result in poor
> performance if you do it for frequently executed instructions.

Ok, thank you.

> That looks like it ought to work. Check you really did save all your
> files in your editor before compiling? :-)

Yes, I did. These warnings are very suspicious, because they come with 
strange numbers of MIPS GPR registers that I receive for my program.

Here is the program:

.text
     addiu $8, $zero, 0x7
     move $9, $8
     sll $8, $8, 3
     add $8, $8, $9

Here is the log that helper functions provide:

$0 00000007
$7 00000007
$0 00000038
$0 0000003f

The first value is register name, the second is the value to be written. 
Values are ok, but I expect to see $8 and $9  registers here.

>
> PS: there's no point passing the env pointer into the function if
> you're not going to use it...

I thought that I need to pass env pointer to helper function because of 
some convention. Again, thank you for the note.

-- 
Sincerely yours,
Sergey Smolov
