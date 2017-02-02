Received: from eggs.gnu.org ([2001:4830:134:3::10]:52868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZ5vr-0005i1-41
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 20:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZ5vo-0002Za-0R
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 20:11:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cZ5vn-0002ZI-Qg
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 20:11:23 -0500
References: <1485870329-79428-1-git-send-email-eswierk@skyportsystems.com>
	<421566746.771522.1485871592528.JavaMail.zimbra@redhat.com>
	<CAO_EM_=PLhSB4JxQitC1zev+RQuSdJqpYyo8rOdVDSvyuoCgkw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e42229ac-9c41-cdf2-6dbb-112086efd70c@redhat.com>
Date: Wed, 1 Feb 2017 17:11:15 -0800
MIME-Version: 1.0
In-Reply-To: <CAO_EM_=PLhSB4JxQitC1zev+RQuSdJqpYyo8rOdVDSvyuoCgkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] char: drop data written to a disconnected
 pty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, marcandre lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Benjamin Warren <ben@skyportsystems.com>



On 31/01/2017 14:19, Ed Swierk wrote:
> Either way, when a pty is disconnected data will get dropped, whether
> by the pty backend (as proposed) or by the serial port device or other
> frontend (as currently).
> 
> The only difference from a user's perspective is whether the dropped
> data gets written to the log file, which is the main motivation for
> this change. The backward compatibility concern would be an existing
> application that relies on data not being logged when the pty is
> disconnected.

Which is clearly a bug and a pointless difference between TCP and pty
backends, so the patch is okay.

Paolo
