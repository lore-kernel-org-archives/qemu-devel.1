Received: from eggs.gnu.org ([2001:4830:134:3::10]:39783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWP1f-0000bK-Su
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWP1d-00051v-DK
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:07:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWP1d-00051H-4y
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:07:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 507E0C02835C
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 17:07:20 +0000 (UTC)
Date: Mon, 10 Dec 2018 15:07:18 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181210170718.GE4669@habkost.net>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181204142023.15982-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v5 00/19] Generalize machine
 compatibility properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com

On Tue, Dec 04, 2018 at 06:20:04PM +0400, Marc-Andr=E9 Lureau wrote:
[...]
> Marc-Andr=E9 Lureau (19):
>   tests: qdev_prop_check_globals() doesn't return "all_used"
>   qom: make interface types abstract
>   qom: make user_creatable_complete() specific to UserCreatable
>   accel: register global_props like machine globals
>   qdev: move qdev_prop_register_global_list() to tests
>   qom: remove unimplemented class_finalize

Patches 1-6 (above) queued on machine-next.  Thanks!

>   hw: apply accel compat properties without touching globals
>   hw: apply machine compat properties without touching globals
>   hw: remove SET_MACHINE_COMPAT
>   qdev: make a separate helper function to apply compat properties
>   qdev: all globals are now user-provided
>   qdev-props: convert global_props to GPtrArray
>   qdev-props: remove errp from GlobalProperty
>   qdev-props: call object_apply_global_props()
>   qom: add object_class_get_class_data()
>   RFC: arm: replace instance_post_init()
>   hw/i386: add pc-i440fx-4.0 & pc-q35-4.0
>   hw/arm/virt: add virt-4.0 machine type
>   hostmem: use object id for memory region name with >=3D 4.0
>=20

--=20
Eduardo
