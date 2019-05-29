Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A7CC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AE820665
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AE820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49765 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVtri-0001tV-Lm
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 04:23:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Paul.Durrant@citrix.com>) id 1hVtqM-000154-Si
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Paul.Durrant@citrix.com>) id 1hVtqL-0000Ks-Oy
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:21:54 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:10524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
	id 1hVtqL-0000Ic-ES
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:21:53 -0400
Authentication-Results: esa3.hc3370-68.iphmx.com;
	dkim=none (message not signed) header.i=none;
	spf=None smtp.pra=Paul.Durrant@citrix.com;
	spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
	spf=None smtp.helo=postmaster@MIAPEX02MSOL01.citrite.net
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
	authenticity information available from domain of
	Paul.Durrant@citrix.com) identity=pra;
	client-ip=23.29.105.83; receiver=esa3.hc3370-68.iphmx.com;
	envelope-from="Paul.Durrant@citrix.com";
	x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
	Paul.Durrant@citrix.com designates 23.29.105.83 as permitted
	sender) identity=mailfrom; client-ip=23.29.105.83;
	receiver=esa3.hc3370-68.iphmx.com;
	envelope-from="Paul.Durrant@citrix.com";
	x-sender="Paul.Durrant@citrix.com";
	x-conformance=sidf_compatible; x-record-type="v=spf1";
	x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
	ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
	ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
	ip4:216.52.6.188 ip4:23.29.105.83 ip4:162.221.156.50 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
	authenticity information available from domain of
	postmaster@MIAPEX02MSOL01.citrite.net) identity=helo;
	client-ip=23.29.105.83; receiver=esa3.hc3370-68.iphmx.com;
	envelope-from="Paul.Durrant@citrix.com";
	x-sender="postmaster@MIAPEX02MSOL01.citrite.net";
	x-conformance=sidf_compatible
IronPort-SDR: QgjiMWa/I70xxpyNkEeXlCg41APGsSuR3uHXLKb5xzzzaBejbFOJqsiyJEJQoil0BEbZ6H83ay
	XZLeh0IBQAmuvA97zdfTt8upGUmi4n0+pj4BMknFlr+GvpLoWVhMCu0NYg4Rs4/hJSe7wBESG7
	joedtFkFjRTxfLmc8jtKntJtLshLh+UGy6FN0g/SfSe6Am3LCvumvWBYD54IB5xyZ4UPv5nhEx
	npTcCRWHnKJpXElMJtH2NdYeKLX9lwv1AP/twXi2KkIksNxz/9zlytWkW5NdiBSzG6PReye1wO
	RAU=
X-SBRS: 2.7
X-MesageID: 1035703
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 23.29.105.83
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.60,526,1549947600"; 
   d="scan'208";a="1035703"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: 'Eduardo Habkost' <ehabkost@redhat.com>, Markus Armbruster
	<armbru@redhat.com>
Thread-Topic: Headers without multiple inclusion guards
Thread-Index: AQHVFYEBg2PnLBQnXE6+nzp55xu0haaAyRGAgAD6mIA=
Date: Wed, 29 May 2019 08:21:33 +0000
Message-ID: <3038b5ea224c4f2b84eb7c1f5fa36134@AMSPEX02CL03.citrite.net>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
	<20190528192317.GG22103@habkost.net>
In-Reply-To: <20190528192317.GG22103@habkost.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.155
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Max Filippov <jcmvbkbc@gmail.com>, Dmitry
	Fleytman <dmitry.fleytman@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek
	Vasut <marex@denx.de>, Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>, Richard
	Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Stafford Horne <shorne@gmail.com>,
	=?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Cornelia Huck <cohuck@redhat.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	=?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
	=?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=20
> [...]
> > Guest CPU Cores (Xen):
> > ----------------------
> >
> > X86
> > M: Stefano Stabellini <sstabellini@kernel.org>
> > M: Anthony Perard <anthony.perard@citrix.com>
> > M: Paul Durrant <paul.durrant@citrix.com>
> > include/hw/xen/io/ring.h
>=20
> I see a __XEN_PUBLIC_IO_RING_H__ guard there.  Probably
> clean-header-guards.pl is confused by the comments at the end of
> the file?
>=20

Yes, I see no problem there. The emacs boilerplate is common in Xen headers=
 and persisted when this was imported.

  Paul

> > [...]
>=20
> --
> Eduardo

