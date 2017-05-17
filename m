Received: from eggs.gnu.org ([2001:4830:134:3::10]:44829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dB6Ye-0004eP-6k
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dB6Yb-000148-45
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:32:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dB6Ya-00013z-U0
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:32:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DF75C049D5D
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 21:32:28 +0000 (UTC)
Date: Wed, 17 May 2017 18:32:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170517213223.GJ4748@thinpad.lan.raisama.net>
References: <20170517212547.4767-1-ehabkost@redhat.com>
	<149505650510.588.4536809278469525716@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149505650510.588.4536809278469525716@c05f1edc8ed1>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] qmp: Return 'user_creatable' &
 'hotpluggable' fields on qom-list-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcel@redhat.com, armbru@redhat.com

On Wed, May 17, 2017 at 02:28:25PM -0700, no-reply@patchew.org wrote:
[...]
>   CC      qmp.o
>   CC      hmp.o
> /var/tmp/patchew-tester-tmp-3wn9eneh/src/qmp.c: In function =E2=80=98qo=
m_list_types_tramp=E2=80=99:
> /var/tmp/patchew-tester-tmp-3wn9eneh/src/qmp.c:452:22: error: =E2=80=98=
DeviceClass {aka struct DeviceClass}=E2=80=99 has no member named =E2=80=98=
user_creatable=E2=80=99
>      bool uc =3D dc ? dc->user_creatable : false;
>                       ^~
> /var/tmp/patchew-tester-tmp-3wn9eneh/src/rules.mak:69: recipe for targe=
t 'qmp.o' failed
> make: *** [qmp.o] Error 1
> make: *** Waiting for unfinished jobs....

This patch is based on Stefan's staging branch, that's why it
won't build properly on qemu.git master.

--=20
Eduardo
