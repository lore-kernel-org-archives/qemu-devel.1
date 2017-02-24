Received: from eggs.gnu.org ([2001:4830:134:3::10]:40099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1chGes-0001jZ-Md
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1chGeo-0008MT-P8
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:15:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1chGeo-0008MG-Ir
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:15:38 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8C2F4E4D3
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 14:15:38 +0000 (UTC)
Message-ID: <1487945735.18529.22.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 24 Feb 2017 15:15:35 +0100
In-Reply-To: <ce5372a6-4fd7-fcff-f773-e8529727b4de@redhat.com>
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
	<1487715299-21102-7-git-send-email-kraxel@redhat.com>
	<ce5372a6-4fd7-fcff-f773-e8529727b4de@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 6/9] virtio-gpu: use graphic_* variables.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

  Hi,

> > +    if (graphic_width && graphic_height) {
> > +        g->req_state[0].width =3D graphic_width;
> > +        g->req_state[0].height =3D graphic_height;
> > +    } else {
> > +        g->req_state[0].width =3D 1024;
> > +        g->req_state[0].height =3D 768;
> > +    }
>=20
> What about adding properties for this, and only using graphic_* as a
> fallback?

Hmm, I guess in that case I'd prefer to not use graphic_* at all ...

cheers,
  Gerd
