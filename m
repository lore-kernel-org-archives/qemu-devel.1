Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39325C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B85206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gItIWjKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B85206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIrFd-0008JU-3l
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 06:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jIrBL-0005MJ-Ai
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jIrBK-0001Ea-1c
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:58:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32906)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jIrBJ-0001E8-UE
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585562289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMWF8QuFs4FdQnn5PR+iMqYMNcjozcoCRuj7TDfrrJM=;
 b=gItIWjKzRvXje15THpQcrK+vY2ecNdx1hqwGq7j0itykDEVv3Lt1h5QW364bXcmhfboWR0
 zOT3OWTYL39kW+VBwF7CB5mzdTsPWB7WyGQJL3eaQF9NU0SgNHJpkjzdjfg0insaXfzBYF
 y2uoCQuI+8sOaBafVl4Xy+J2OhG1JMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-a80OJPh6OOmn0-tzar3j5w-1; Mon, 30 Mar 2020 05:58:02 -0400
X-MC-Unique: a80OJPh6OOmn0-tzar3j5w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72A47800D50;
 Mon, 30 Mar 2020 09:58:00 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CFC05C1B5;
 Mon, 30 Mar 2020 09:57:57 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v7 09/13] arm/arm64: ITS: Commands
To: Zenghui Yu <yuzenghui@huawei.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-10-eric.auger@redhat.com>
 <84493416-7b0d-df3e-df56-cedcbdd72010@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <885f656f-08a4-7e7b-f2b8-0e3921a58bb9@redhat.com>
Date: Mon, 30 Mar 2020 11:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <84493416-7b0d-df3e-df56-cedcbdd72010@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, thuth@redhat.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zenghui,

On 3/30/20 11:22 AM, Zenghui Yu wrote:
> Hi Eric,
>=20
> On 2020/3/20 17:24, Eric Auger wrote:
>> Implement main ITS commands. The code is largely inherited from
>> the ITS driver.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> [...]
>=20
>> +/* ITS COMMANDS */
>> +
>> +static void its_encode_cmd(struct its_cmd_block *cmd, u8 cmd_nr)
>> +{
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[0] &=3D ~0xffUL;
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[0] |=3D cmd_nr;
>> +}
>> +
>> +static void its_encode_devid(struct its_cmd_block *cmd, u32 devid)
>> +{
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[0] &=3D BIT_ULL(32) - 1;
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[0] |=3D ((u64)devid) << 32;
>> +}
>> +
>> +static void its_encode_event_id(struct its_cmd_block *cmd, u32 id)
>> +{
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[1] &=3D ~0xffffffffUL;
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[1] |=3D id;
>> +}
>> +
>> +static void its_encode_phys_id(struct its_cmd_block *cmd, u32 phys_id=
)
>> +{
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[1] &=3D 0xffffffffUL;
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[1] |=3D ((u64)phys_id) << 32;
>> +}
>> +
>> +static void its_encode_size(struct its_cmd_block *cmd, u8 size)
>> +{
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[1] &=3D ~0x1fUL;
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[1] |=3D size & 0x1f;
>> +}
>> +
>> +static void its_encode_itt(struct its_cmd_block *cmd, u64 itt_addr)
>> +{
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[2] &=3D ~0xffffffffffffUL;
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[2] |=3D itt_addr & 0xffffffffff00UL;
>> +}
>> +
>> +static void its_encode_valid(struct its_cmd_block *cmd, int valid)
>> +{
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[2] &=3D ~(1UL << 63);
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[2] |=3D ((u64)!!valid) << 63;
>> +}
>> +
>> +static void its_encode_target(struct its_cmd_block *cmd, u64
>> target_addr)
>> +{
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[2] &=3D ~(0xfffffffffUL << 16);
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[2] |=3D (target_addr & (0xffffffffUL =
<< 16));
>> +}
>> +
>> +static void its_encode_collection(struct its_cmd_block *cmd, u16 col)
>> +{
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[2] &=3D ~0xffffUL;
>> +=C2=A0=C2=A0=C2=A0 cmd->raw_cmd[2] |=3D col;
>> +}
>=20
> The command encoding can be refactored like:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D4d36f136d57aea6f6440886106e246bb7e5918d8
>=20
>=20
> which will look much clearer.
OK
>=20
> [...]
>=20
>> +static void its_send_single_command(its_cmd_builder_t builder,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct its_cmd_desc *desc)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct its_cmd_block *cmd, *next_cmd;
>> +
>> +=C2=A0=C2=A0=C2=A0 cmd =3D its_allocate_entry();
>> +=C2=A0=C2=A0=C2=A0 builder(cmd, desc);
>> +=C2=A0=C2=A0=C2=A0 next_cmd =3D its_post_commands();
>> +
>> +=C2=A0=C2=A0=C2=A0 its_wait_for_range_completion(cmd, next_cmd);
>> +}
>> +
>> +
>=20
> extra line.
OK
>=20
>> +static void its_build_mapd_cmd(struct its_cmd_block *cmd,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct its_cmd_desc *desc)
>> +{
>> +=C2=A0=C2=A0=C2=A0 unsigned long itt_addr;
>> +=C2=A0=C2=A0=C2=A0 u8 size =3D 12; /* 4096 eventids */
>=20
> Maybe use desc->its_mapd_cmd.dev->nr_ites instead as we already have it=
?
OK
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 itt_addr =3D (unsigned
>> long)(virt_to_phys(desc->its_mapd_cmd.dev->itt));
>> +=C2=A0=C2=A0=C2=A0 itt_addr =3D ALIGN(itt_addr, ITS_ITT_ALIGN);
>> +
>> +=C2=A0=C2=A0=C2=A0 its_encode_cmd(cmd, GITS_CMD_MAPD);
>> +=C2=A0=C2=A0=C2=A0 its_encode_devid(cmd, desc->its_mapd_cmd.dev->devi=
ce_id);
>> +=C2=A0=C2=A0=C2=A0 its_encode_size(cmd, size - 1);
>> +=C2=A0=C2=A0=C2=A0 its_encode_itt(cmd, itt_addr);
>> +=C2=A0=C2=A0=C2=A0 its_encode_valid(cmd, desc->its_mapd_cmd.valid);
>> +=C2=A0=C2=A0=C2=A0 its_fixup_cmd(cmd);
>> +=C2=A0=C2=A0=C2=A0 if (desc->verbose)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("ITS: MAPD devid=3D=
%d size =3D 0x%x itt=3D0x%lx valid=3D%d\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
sc->its_mapd_cmd.dev->device_id,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
ze, itt_addr, desc->its_mapd_cmd.valid);
>> +
>=20
> extra line.
>=20
> All of these are trivial things and feel free to ignore them,
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
thanks!

Eric
>=20
>=20
> Thanks
>=20


