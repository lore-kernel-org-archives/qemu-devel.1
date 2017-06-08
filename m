Received: from eggs.gnu.org ([2001:4830:134:3::10]:53346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ19w-0005F7-Nh
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ19t-0004Wu-BE
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:23:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJ19t-0004Wq-5O
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:23:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEBD2B1E33
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 17:23:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-20-marcandre.lureau@redhat.com>
Date: Thu, 08 Jun 2017 19:23:39 +0200
In-Reply-To: <20170607163635.17635-20-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 7 Jun 2017
	20:36:11 +0400")
Message-ID: <87shja1jhg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 19/43] qdev: use appropriate
 getter/setters type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Based on the underlying type of the data accessed, use the appropriate
> getters/setters.

Enumerating data here would be nice.

* AcpiPmInfo members s3_disabled, s4_disabled are bool, member s4_val is
  an uint8_t.

* Property ACPI_PCIHP_IO_PROP is defined with
  object_property_add_uint32_ptr().

* Property PCIE_HOST_MCFG_SIZE is implemented with visit_type_uint64()

* PCIDevice property "addr" is backed by PCIDevice member devfn, which
  is an int32_t.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Preferably with a more detailed commit message:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
