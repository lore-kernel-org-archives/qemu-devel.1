Received: from eggs.gnu.org ([2001:4830:134:3::10]:58047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAXbK-00076Z-80
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAXbG-0005AW-SP
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:49:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAXbG-0005A6-M4
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:49:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180928075832.18586-1-w.bumiller@proxmox.com>
	<20180928075832.18586-3-w.bumiller@proxmox.com>
	<CAJ+F1CL4S8aLm6ayu7GfKMfySTBTuUS3j2cuni-+ErEp5Y8VLQ@mail.gmail.com>
	<20180928095543.GN9560@xz-x1> <87r2gx8073.fsf@dusky.pond.sub.org>
	<20181011082307.wvzu4urbsnemp5fn@olga.proxmox.com>
Date: Thu, 11 Oct 2018 11:49:39 +0200
In-Reply-To: <20181011082307.wvzu4urbsnemp5fn@olga.proxmox.com> (Wolfgang
	Bumiller's message of "Thu, 11 Oct 2018 10:23:07 +0200")
Message-ID: <87woqo6cek.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/2] monitor: delay monitor iothread
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>

Wolfgang Bumiller <w.bumiller@proxmox.com> writes:

> On Thu, Oct 11, 2018 at 08:30:24AM +0200, Markus Armbruster wrote:
[...]
>> Since the bug is inconveniencing people, should I merge v1 for now?  We
>> can then figure out how to improve on it.
>
> Tbh I'm unsure which way to proceed at this point.

Don't worry, ball's in my court for now.
