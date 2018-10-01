Received: from eggs.gnu.org ([2001:4830:134:3::10]:53682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g6tWW-0003MB-IN
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g6tWS-0003wd-GA
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:25:48 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g6tWS-0003w3-8V
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:25:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id q8-v6so7764562wmq.4
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 01:25:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1538295197-23704-1-git-send-email-pbonzini@redhat.com>
	<572f8674-1712-686a-278e-9eae5947a233@amsat.org>
	<5a4400ff-5eed-6deb-9986-a63abca495b6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <22b1d8c9-50fb-6317-eff7-1bd9376be851@amsat.org>
Date: Mon, 1 Oct 2018 10:25:41 +0200
MIME-Version: 1.0
In-Reply-To: <5a4400ff-5eed-6deb-9986-a63abca495b6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/79] Misc QEMU patches for 2018-09-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On 10/1/18 10:11 AM, Paolo Bonzini wrote:
> On 30/09/2018 16:54, Philippe Mathieu-Daudé wrote:
>> Hi Paolo, Peter.
>>
>> On 9/30/18 10:11 AM, Paolo Bonzini wrote:
>>> The following changes since commit 042938f46e1c477419d1931381fdadffaa49d45e:
>>>
>>>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180926a' into staging (2018-09-28 17:07:23 +0100)
>>>
>>> are available in the git repository at:
>>>
>>>
>>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>>
>>> for you to fetch changes up to 54b570779677ff8620a79ed81ddf0906b1d23f4e:
>>>
>>>   hw/scsi/mptendian: Avoid taking address of fields in packed structs (2018-09-30 10:08:28 +0200)
>>>
>>> ----------------------------------------------------------------
>>> * configure fix for environment variables (Daniel)
>>> * fix memory leaks (Alex)
>>> * x86_64 MTTCG (Emilio)
>>> * introduce atomic64 (Emilio)
>>> * Fix for virtio hang (Fam, myself)
>>> * SH serial port fix (Geert)
>>> * Deprecate rotation_rate for scsi-block (Fam)
>>> * Extend memory-backend-file availability to all POSIX hosts (Hikaru)
>>> * Memory API cleanups and fixes (Igor, Li Qiang, Peter, Philippe)
>>> * MSI/IOMMU fix (Jan)
>>> * Socket reconnection fixes (Marc-André)
>>> * icount fixes (Emilio, myself)
>>> * QSP fixes for Coverity (myself)
>>> * Some record/replay improovements (Pavel)
>>> * Packed struct fixes (Peter)
>>> * Windows dump fixes and elf2dmp (Viktor)
>>> * kbmclock fix (Yongji)
>>
>> Paolo, thanks for queuing all of this, however I note some UTF-8 issues.
>>
>> Alex got lucky:
>>
>>  Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> But Marc-André and myself have:
>>
>>  Signed-off-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
>>  Signed-off-by: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
> 
> I'll fix it.  In the meanwhile, I'll note that we're also improving
> Patchew so that it is much better at applying patches via three-way
> merge (basically the adding of *-by tags moves from "patchew apply" to
> the web stuff) and that should make these UTF-8 issues a thing of the past.

I noticed my patches are missing Cédric's R-b tags, is it a patchew
restriction?

Regards,

Phil.
