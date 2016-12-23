Received: from eggs.gnu.org ([2001:4830:134:3::10]:34912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cKN2V-0004yG-1h
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 05:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cKN2P-0004pz-ND
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 05:25:27 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cKN2P-0004pM-GG
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 05:25:21 -0500
Received: by mail-wj0-f196.google.com with SMTP id hb5so6408695wjc.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 02:25:21 -0800 (PST)
References: <585c0f59.2350c20a.e5711.e639@mx.google.com>
	<6897002c-9618-ba6b-3d42-8595bb13ac09@tuxfamily.org>
	<1742192160.5141190.1482484832078.JavaMail.zimbra@redhat.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <b1eadebd-2585-94e9-447b-252c7654691a@tuxfamily.org>
Date: Fri, 23 Dec 2016 11:25:18 +0100
MIME-Version: 1.0
In-Reply-To: <1742192160.5141190.1482484832078.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] virus in colibriOS QEMU iso?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vilcadam@gmail.com
Cc: Kashyap Chamarthy <kashyapc@fedoraproject.org>, qemu-devel@nongnu.org

On 23.12.2016 10:20, Kashyap Chamarthy wrote:
> [...]
> 
>> On 22.12.2016 18:37, vilcadam@gmail.com wrote:
>>> Hi, just letting you know that Avira found some crypto-locker virus in
>>> ColibriOS iso that you featured in QEMU Advent Calendar 2016. Maybe you
>>> should look into that. I am not sure if it’s a false positive or not.. You
>>> can check the attachment for a screenshot  of the result.
>>
>> That sounds ugly ... 
> 
> That sounds super ugly indeed :-(
> 
>> I think we just packaged the .iso from the official
>> KolibriOS website here (Kashyap, can you confirm?),
> 
> Yes, I can confirm that I have downloaded the ISO from the 
> official website -- it's a nightly build of their 
> SVN revision 6766.

OK, as far as I can see, the issue comes from the setmbr.exe that is
contained in the iso for writing the KolibriOS to an USB stick.
According to http://board.kolibrios.org/viewtopic.php?t=2295 the report
from Avira is a false positive (likely caused because the program tries
to write to the MBR - which is also what some viruses / trojans are doing).

Anyway, since these Windows tools are not required for running KolibriOS
in a VM, I've now removed them from the iso image and uploaded a new
version to avoid future confusion:

 http://www.qemu-advent-calendar.org/2016/download/day09-v2.tar.xz

If you've got some spare minutes, it would be great if you could give
that new version another try to see whether the warning from Avira is
now properly gone (I don't have a Windows here to test this on my own).

 Thanks,
  Thomas
