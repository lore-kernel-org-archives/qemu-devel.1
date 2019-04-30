Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFC0C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E122147A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E122147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48142 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLU2O-00016q-Gi
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 10:47:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hLU18-0000OU-Tv
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hLU17-00015j-3w
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:45:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hLU16-00014S-QK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:45:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D98C081DF1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 14:45:53 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 64D9A1001E66;
	Tue, 30 Apr 2019 14:45:49 +0000 (UTC)
Date: Tue, 30 Apr 2019 15:45:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190430144546.GA3065@work-vm>
References: <20190430131919.GN6818@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190430131919.GN6818@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 30 Apr 2019 14:45:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] QMP; unsigned 64-bit ints;
 JSON standards compliance
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
Cc: libvir-list@redhat.com, =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430144546.zpRpWz18wFNh2dOa_q3AHfi80bqcNIn3XL1AUZa0tiA@z>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> The QEMU  QMP service is based on JSON which is nice because that is a
> widely supported "standard" data format.....
>=20
> ....except QEMU's implementation (and indeed most impls) are not strict=
ly
> standards compliant.
>=20
> Specifically the problem is around representing 64-bit integers, whethe=
r
> signed or unsigned.
>=20
> The JSON standard declares that largest integer is 2^53-1 and the
> likewise the smallest is -(2^53-1):
>=20
>   http://www.ecma-international.org/ecma-262/6.0/index.html#sec-number.=
max_safe_integer
>=20
> A crazy limit inherited from its javascript origins IIUC.

Ewwww.

> QEMU, and indeed many applications, want to handle 64-bit integers.
> The C JSON library impls have traditionally mapped integers to the
> data type 'long long int' which gives a min/max of  -(2^63) / 2^63-1.
>=20
> QEMU however /really/ needs 64-bit unsigned integers, ie a max 2^64-1.
>=20
> Libvirt has historically used the YAJL library which uses 'long long in=
t'
> and thus can't officially go beyond 2^63-1 values. Fortunately it lets
> libvirt get at the raw json string, so libvirt can re-parse the value
> to get an 'unsigned long long'.
>=20
> We recently tried to switch to Jansson because YAJL has a dead upstream
> for many years and countless unanswered bugs & patches. Unfortunately w=
e
> forgot about this need for 2^64-1 max, and Jansson also uses 'long long=
 int'
> and raises a fatal parse error for unsigned 64-bit values above 2^63-1.=
 It
> also provides no backdoor for libvirt todo its own integer parsing. Thu=
s
> we had to abort our switch to jansson as it broke parsing QEMU's JSON:
>=20
>   https://bugzilla.redhat.com/show_bug.cgi?id=3D1614569
>=20
> Other JSON libraries we've investigated have similar problems. I imagin=
e
> the same may well be true of non-C based JOSN impls, though I've not
> investigated in any detail.
>=20
> Essentially libvirt is stuck with either using the dead YAJL library
> forever, or writing its own JSON parser (most likely copying QEMU's
> JSON code into libvirt's git).
>=20
> This feels like a very unappealing situation to be in as not being
> able to use a JSON library of our choice is loosing one of the key
> benefits of using a standard data format.
>=20
> Thus I'd like to see a solution to this to allow QMP to be reliably
> consumed by any JSON library that exists.
>=20
> I can think of some options:
>=20
>   1. Encode unsigned 64-bit integers as signed 64-bit integers.
>=20
>      This follows the example that most C libraries map JSON ints
>      to 'long long int'. This is still relying on undefined
>      behaviour as apps don't need to support > 2^53-1.
>=20
>      Apps would need to cast back to 'unsigned long long' for
>      those QMP fields they know are supposed to be unsigned.
>=20
>=20
>   2. Encode all 64-bit integers as a pair of 32-bit integers.
>    =20
>      This is fully compliant with the JSON spec as each half
>      is fully within the declared limits. App has to split or
>      assemble the 2 pieces from/to a signed/unsigned 64-bit
>      int as needed.
>=20
>=20
>   3. Encode all 64-bit integers as strings
>=20
>      The application has todo all parsing/formatting client
>      side.
>=20
>=20
> None of these changes are backwards compatible, so I doubt we could mak=
e
> the change transparently in QMP.  Instead we would have to have a
> QMP greeting message capability where the client can request enablement
> of the enhanced integer handling.
>=20
> Any of the three options above would likely work for libvirt, but I
> would have a slight preference for either 2 or 3, so that we become
> 100% standards compliant.

My preference would be 3 with the strings defined as being
%x lower case hex formated with a 0x prefix and no longer than 18 charact=
ers
("0x" + 16 nybbles). Zero padding allowed but not required.
It's readable and unambiguous when dealing with addresses; I don't want
to have to start decoding (2) by hand when debugging.


Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

