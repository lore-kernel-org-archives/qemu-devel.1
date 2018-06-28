Received: from eggs.gnu.org ([2001:4830:134:3::10]:37611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYd9g-0006dI-HN
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYd9d-0006tr-Dy
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:04:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51918 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYd9d-0006se-9W
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:04:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45B9B406AE3F
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 20:04:32 +0000 (UTC)
References: <20180607101019.14958-1-berrange@redhat.com>
	<20180628131722.GA13766@redhat.com>
	<8964dea3-042d-2eac-0198-d50c9c8947fc@redhat.com>
	<03c1e60e-6f5b-51cb-afe1-9f4e26a2c56b@redhat.com>
	<20180628162941.GT3513@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <11e8e519-e378-02f4-a88d-329e16915432@redhat.com>
Date: Thu, 28 Jun 2018 22:04:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180628162941.GT3513@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] doc: switch to modern syntx for VNC TLS
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On 28/06/2018 18:29, Daniel P. Berrang=C3=A9 wrote:
> Yeah, in this case I'd rather stick with single dash, for consistency,
> since this example is not applicable to non-system emulators anyway.
>=20
>> I honestly don't understand the crusade against single-dashed options.
> It does cause confusion in some documentation contexts with -object,
> since qemu-nbd/qemu-img/qemu-io all mandated --object instead.

It's okay if you're documenting --object.  But I think consistency
should win when you are showing examples for QEMU; then all options
should use either single or double dashes.

Paolo
