Received: from eggs.gnu.org ([2001:4830:134:3::10]:51799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNUdK-00088Z-SS
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 21:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNUdH-0004SW-JY
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 21:40:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dNUdH-0004SM-EI
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 21:40:35 -0400
References: <1497937927-19738-1-git-send-email-thuth@redhat.com>
	<1497937927-19738-9-git-send-email-thuth@redhat.com>
	<d76ab927-ba90-f8d1-000d-b596edeccfcb@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6639c0c3-0db4-d96e-8227-6b5bf169d232@redhat.com>
Date: Wed, 21 Jun 2017 03:40:31 +0200
MIME-Version: 1.0
In-Reply-To: <d76ab927-ba90-f8d1-000d-b596edeccfcb@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 8/8] hw/misc/edu: Compile the edu device
 as common object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 20.06.2017 20:14, Richard Henderson wrote:
> On 06/19/2017 10:52 PM, Thomas Huth wrote:
>> edu.c does not contain any target-specific code, so we can put
>> it into common-obj-y to compile it only once for all targets.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> Isn't CONFIG_EDU defined by the target, via pci.conf?
> Would it ever be set generically?

This is about Makefiles, not #defines in C sources ... so if I
understand our build-system correctly, the variable is set for the
Makefiles of the targets that use pci.mak. As far as I see, it gets
compiled correctly here.
And we've got plenty of those common-obj-$(CONFIG_xxx) statements
elsewhere in this file (e.g. for CONFIG_PCI_TESTDEV which is also
declared in default-configs/pci.mak), so this is just normal, no problem
here, as far as I can tell.

 Thomas
