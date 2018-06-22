Received: from eggs.gnu.org ([2001:4830:134:3::10]:53632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWNo8-0002b8-8c
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWNo4-0006DP-FJ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:17:04 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:38922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWNo4-0006Cx-A2
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:17:00 -0400
Received: by mail-qt0-x241.google.com with SMTP id p23-v6so6199830qtn.6
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 08:17:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<263756cc-6869-de24-3f9b-140d24025829@amsat.org>
	<5d9fc1151a1045eab8c6ace71b772f94@mips.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b80b128f-916a-a114-97e3-96705321503d@amsat.org>
Date: Fri, 22 Jun 2018 12:16:54 -0300
MIME-Version: 1.0
In-Reply-To: <5d9fc1151a1045eab8c6ace71b772f94@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/35] nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <Aleksandar.Markovic@mips.com>, Yongbok Kim <Yongbok.Kim@mips.com>, James Hogan <James.Hogan@mips.com>
Cc: Paul Burton <Paul.Burton@mips.com>, Stefan Markovic <Stefan.Markovic@mips.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Matthew Fortune <Matthew.Fortune@mips.com>

Hi Aleksandar,

On 06/22/2018 11:39 AM, Aleksandar Markovic wrote:
>> From: Philippe Mathieu-Daudé <philippe.mathieu.daude@gmail.com> on behalf of Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Sent: Friday, June 22, 2018 6:26 AM
>> To: Yongbok Kim; James Hogan
>> Cc: qemu-devel@nongnu.org; Aleksandar Markovic; Paul Burton; Stefan Markovic; Matthew Fortune; aurelien@aurel32.net; Paul Burton
>> Subject: Re: [Qemu-devel] [PATCH 00/35] nanoMIPS
>>
>> Hi Yongbok,
>>
>> On 06/20/2018 09:05 AM, Yongbok Kim wrote:
>>> This series of patches is implementing recently announced nanoMIPS on QEMU.
>>> nanoMIPS is a variable length ISA containing 16, 32 and 48 bit wide
>>> instructions. It is designed to be portable at assembly level with other MIPS
>>> and microMIPS code, but contains a number of changes which enhance code density
>>> and efficiency.
>> [...]
>>
>> I noticed various patches use the imgtec.com domain.
>>
>> In commit 94d973bdaac Paul Burton wrote:
>>
>>     MIPS will soon no longer be a part of Imagination Technologies
>>     & as such the @imgtec.com address will soon cease to function.
>>
>> Your's got updated in 0eb4e1f33a4, and James in a7a2d7d2a04.
>>
>> Assuming this is rebase using previous internal patches, shouldn't you
>> update those addresses to your new domain? Else the checkpatch.pl script
>> will continue to extract imgtec.com addresses from commits.
> 
> Thanks for spotting this, Philippe! It probably slipped through the cracks.
> 
> If nobody objects, while integrating/applying, I am going to change all instances of "@imgtec.com" to "@mips.com" for this series.
> 
> Some of the patches might have been developed while the company was part of Imagination Technologies - however, I think it is reasonable to use email addresses at the moment of submitting changes to this list. This gets complicated if, for example, a person leaves the company before his/her email address changes, but I think, in this case, using "@mips.com" is appropriate for all involved persons.

Well, since imgtec.com entries are in .mailmap, and get_maintainer.pl
parses it, maybe there is a bug in the script.

The 'From' is used for the git author, and IMO should be @mips.com.

To respect Imagination Technologies efforts, can this work?

Signed-off-by: James Hogan <james.hogan@mips.com> for Imagination
Technologies

This shouldn't break scripts. However not all names fit in less than 80
characters...

> 
> Regards,
> 
> Aleksandar
> 
>>
>> Regards,
>>
>> Phil.
