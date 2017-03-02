Received: from eggs.gnu.org ([2001:4830:134:3::10]:60162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjV9F-0000AR-OE
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjV9C-0003AM-It
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:08:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjV9C-0003A4-CJ
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:08:14 -0500
References: <1488472983-9108-1-git-send-email-felipe@nutanix.com>
	<148847375468.285.999031041241417996@0e2666bad730>
	<F9FA9F92-B44C-401D-A892-D73D36777B47@nutanix.com>
	<20170302171721.GG11445@redhat.com>
	<3FB730F1-6067-4FD4-8D3F-19C648472B1B@nutanix.com>
	<20170302173214.GH11445@redhat.com>
	<76385409-F13F-41AE-8BA4-18AA3406E58F@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a788026-eae6-f7f9-badf-3c235d8d49f2@redhat.com>
Date: Thu, 2 Mar 2017 19:08:09 +0100
MIME-Version: 1.0
In-Reply-To: <76385409-F13F-41AE-8BA4-18AA3406E58F@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Introduce vhost-user-scsi and
 sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>



On 02/03/2017 18:39, Felipe Franciosi wrote:
>> Yeah, it wasn't previously noticed since these files weren't compiled
>> by default. Since you've added make rules to enable build, I'm afraid
>> you've got the unfortunate job of cleaning up pre-existing build
>> problems. I'd suggest just doing the conversion to g_strdup_vprintf()
>> in the first patch your series.
> 
> That's ok. I'll wait to see if Paolo has any other comments on v4 and then I'll send a v5 which includes this change.

Just a note that this has missed 2.9 now, so I'll look at it but not
right now. :(

Paolo
