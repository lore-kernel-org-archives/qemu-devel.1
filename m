Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38DDC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8704320873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e57DSEB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8704320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1jQ-00069Q-N2
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jC1ih-0004lB-Vr
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jC1ig-0006HH-ND
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:48:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40070
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jC1ig-0006HB-Je
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojxoxR+MHQtWUQ/abjg7bLaa0SyuDx1Bi9ausr3HrUw=;
 b=e57DSEB9UXOH3K0A9Tu+BMnloQTKorhBRs+lCp6uCGt8b24umDSSvCl/utBWOdK0YDsVUD
 PaQ8eqwAlL4NdKcqdvwEcHyFeEw1I+hpCrC6hMdeGvy20nuJQSZbGAdLGHpFQ5lYg1f3Ty
 kf9azlU3/5H7e0TcFs7aa83ObTZdSgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-TwTOY6s4MGWF3JJ6-DH5-w-1; Wed, 11 Mar 2020 09:48:20 -0400
X-MC-Unique: TwTOY6s4MGWF3JJ6-DH5-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 687EE1005509;
 Wed, 11 Mar 2020 13:48:18 +0000 (UTC)
Received: from [10.36.118.12] (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 114CA60CC0;
 Wed, 11 Mar 2020 13:48:13 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v5 10/13] arm/arm64: ITS: INT functional
 tests
To: Zenghui Yu <yuzenghui@huawei.com>, eric.auger.pro@gmail.com,
 maz@kernel.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200310145410.26308-1-eric.auger@redhat.com>
 <20200310145410.26308-11-eric.auger@redhat.com>
 <d3f651a0-2344-4d6e-111b-be133db7e068@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <46f0ed1d-3bda-f91b-e2b0-addf1c61c373@redhat.com>
Date: Wed, 11 Mar 2020 14:48:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d3f651a0-2344-4d6e-111b-be133db7e068@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: andre.przywara@arm.com, drjones@redhat.com, alexandru.elisei@arm.com,
 thuth@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zenghui,

On 3/11/20 12:59 PM, Zenghui Yu wrote:
> Hi Eric,
>=20
> On 2020/3/10 22:54, Eric Auger wrote:
>> Triggers LPIs through the INT command.
>>
>> the test checks the LPI hits the right CPU and triggers
>> the right LPI intid, ie. the translation is correct.
>>
>> Updates to the config table also are tested, along with inv
>> and invall commands.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>=20
> [...]
>=20
>> +static void test_its_trigger(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct its_collection *col3, *col2;
>> +=C2=A0=C2=A0=C2=A0 struct its_device *dev2, *dev7;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (its_prerequisites(4))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 dev2 =3D its_create_device(2 /* dev id */, 8 /* nb=
_ites */);
>> +=C2=A0=C2=A0=C2=A0 dev7 =3D its_create_device(7 /* dev id */, 8 /* nb=
_ites */);
>> +
>> +=C2=A0=C2=A0=C2=A0 col3 =3D its_create_collection(3 /* col id */, 3/*=
 target PE */);
>> +=C2=A0=C2=A0=C2=A0 col2 =3D its_create_collection(2 /* col id */, 2/*=
 target PE */);
>> +
>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT);
>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_set_config(8196, LPI_PROP_DEFAULT);
>> +
>> +=C2=A0=C2=A0=C2=A0 its_send_invall(col2);
>> +=C2=A0=C2=A0=C2=A0 its_send_invall(col3);
>=20
> These two INVALLs should be issued after col2 and col3 are mapped,
> otherwise this will cause the INVALL command error as per the spec
> (though KVM doesn't complain it at all).
Yes you're right. reading the spec again:

A command error occurs if any of the following apply:
../..
The collection specified by ICID has not been mapped to an RDbase using
MAPC.

But as mentionned in the cover letter, no real means to retrieve the
error at the moment.

>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 report_prefix_push("int");
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * dev=3D2, eventid=3D20=C2=A0 -> lpi=3D 8195=
, col=3D3
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * dev=3D7, eventid=3D255 -> lpi=3D 8196, col=
=3D2
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Trigger dev2, eventid=3D20 and dev7, event=
id=3D255
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Check both LPIs hit
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +
>> +=C2=A0=C2=A0=C2=A0 its_send_mapd(dev2, true);
>> +=C2=A0=C2=A0=C2=A0 its_send_mapd(dev7, true);
>> +
>> +=C2=A0=C2=A0=C2=A0 its_send_mapc(col3, true);
>> +=C2=A0=C2=A0=C2=A0 its_send_mapc(col2, true);
>> +
>> +=C2=A0=C2=A0=C2=A0 its_send_mapti(dev2, 8195 /* lpi id */, 20 /* even=
t id */, col3);
>> +=C2=A0=C2=A0=C2=A0 its_send_mapti(dev7, 8196 /* lpi id */, 255 /* eve=
nt id */, col2);
>> +
>> +=C2=A0=C2=A0=C2=A0 lpi_stats_expect(3, 8195);
>> +=C2=A0=C2=A0=C2=A0 its_send_int(dev2, 20);
>> +=C2=A0=C2=A0=C2=A0 check_lpi_stats("dev=3D2, eventid=3D20=C2=A0 -> lp=
i=3D 8195, col=3D3");
>> +
>> +=C2=A0=C2=A0=C2=A0 lpi_stats_expect(2, 8196);
>> +=C2=A0=C2=A0=C2=A0 its_send_int(dev7, 255);
>> +=C2=A0=C2=A0=C2=A0 check_lpi_stats("dev=3D7, eventid=3D255 -> lpi=3D =
8196, col=3D2");
>> +
>> +=C2=A0=C2=A0=C2=A0 report_prefix_pop();
>> +
>> +=C2=A0=C2=A0=C2=A0 report_prefix_push("inv/invall");
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * disable 8195, check dev2/eventid=3D20 does=
 not trigger the
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * corresponding LPI
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT & ~LPI=
_PROP_ENABLED);
>> +=C2=A0=C2=A0=C2=A0 its_send_inv(dev2, 20);
>> +
>> +=C2=A0=C2=A0=C2=A0 lpi_stats_expect(-1, -1);
>> +=C2=A0=C2=A0=C2=A0 its_send_int(dev2, 20);
>> +=C2=A0=C2=A0=C2=A0 check_lpi_stats("dev2/eventid=3D20 does not trigge=
r any LPI");
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * re-enable the LPI but willingly do not cal=
l invall
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * so the change in config is not taken into =
account.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The LPI should not hit
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT);
>> +=C2=A0=C2=A0=C2=A0 lpi_stats_expect(-1, -1);
>> +=C2=A0=C2=A0=C2=A0 its_send_int(dev2, 20);
>> +=C2=A0=C2=A0=C2=A0 check_lpi_stats("dev2/eventid=3D20 still does not =
trigger any LPI");
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Now call the invall and check the LPI hits */
>> +=C2=A0=C2=A0=C2=A0 its_send_invall(col3);
>> +=C2=A0=C2=A0=C2=A0 lpi_stats_expect(3, 8195);
>> +=C2=A0=C2=A0=C2=A0 its_send_int(dev2, 20);
>> +=C2=A0=C2=A0=C2=A0 check_lpi_stats("dev2/eventid=3D20 now triggers an=
 LPI");
>> +
>> +=C2=A0=C2=A0=C2=A0 report_prefix_pop();
>> +
>> +=C2=A0=C2=A0=C2=A0 report_prefix_push("mapd valid=3Dfalse");
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Unmap device 2 and check the eventid 20 fo=
rmerly
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * attached to it does not hit anymore
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +
>> +=C2=A0=C2=A0=C2=A0 its_send_mapd(dev2, false);
>> +=C2=A0=C2=A0=C2=A0 lpi_stats_expect(-1, -1);
>> +=C2=A0=C2=A0=C2=A0 its_send_int(dev2, 20);
>> +=C2=A0=C2=A0=C2=A0 check_lpi_stats("no LPI after device unmap");
>> +=C2=A0=C2=A0=C2=A0 report_prefix_pop();
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Unmap the collection this time and check no LPI=
 does hit */
>> +=C2=A0=C2=A0=C2=A0 report_prefix_push("mapc valid=3Dfalse");
>> +=C2=A0=C2=A0=C2=A0 its_send_mapc(col2, false);
>=20
> And as for the MAPC, the spec says:
>=20
> " When V is 0:
> Behavior is unpredictable if there are interrupts that are mapped to th=
e
> specified collection, with the restriction that further translation
> requests from that device are ignored. "
>=20
> So this collection-unmap test may not make sense?
makes sense. Removing it.
>=20
>> +=C2=A0=C2=A0=C2=A0 lpi_stats_expect(-1, -1);
>> +=C2=A0=C2=A0=C2=A0 its_send_int(dev7, 255);
>> +=C2=A0=C2=A0=C2=A0 check_lpi_stats("no LPI after collection unmap");
>> +=C2=A0=C2=A0=C2=A0 report_prefix_pop();
>> +}
>=20
> [...]
>=20
> Otherwise looks good.
Thanks!

Eric
>=20
>=20
> Thanks,
> Zenghui
>=20


