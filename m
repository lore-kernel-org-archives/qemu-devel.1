Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9292C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B951206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B951206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIqe9-0002pQ-Fw
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 05:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1jIqdF-0001z6-Sv
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1jIqdE-0008JF-81
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:22:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43410 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1jIqd9-0008G2-Dn; Mon, 30 Mar 2020 05:22:52 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3476A1E97E7AB0E559FA;
 Mon, 30 Mar 2020 17:22:47 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 17:22:39 +0800
Subject: Re: [kvm-unit-tests PATCH v7 09/13] arm/arm64: ITS: Commands
To: Eric Auger <eric.auger@redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-10-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <84493416-7b0d-df3e-df56-cedcbdd72010@huawei.com>
Date: Mon, 30 Mar 2020 17:22:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200320092428.20880-10-eric.auger@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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

Hi Eric,

On 2020/3/20 17:24, Eric Auger wrote:
> Implement main ITS commands. The code is largely inherited from
> the ITS driver.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

[...]

> +/* ITS COMMANDS */
> +
> +static void its_encode_cmd(struct its_cmd_block *cmd, u8 cmd_nr)
> +{
> +	cmd->raw_cmd[0] &= ~0xffUL;
> +	cmd->raw_cmd[0] |= cmd_nr;
> +}
> +
> +static void its_encode_devid(struct its_cmd_block *cmd, u32 devid)
> +{
> +	cmd->raw_cmd[0] &= BIT_ULL(32) - 1;
> +	cmd->raw_cmd[0] |= ((u64)devid) << 32;
> +}
> +
> +static void its_encode_event_id(struct its_cmd_block *cmd, u32 id)
> +{
> +	cmd->raw_cmd[1] &= ~0xffffffffUL;
> +	cmd->raw_cmd[1] |= id;
> +}
> +
> +static void its_encode_phys_id(struct its_cmd_block *cmd, u32 phys_id)
> +{
> +	cmd->raw_cmd[1] &= 0xffffffffUL;
> +	cmd->raw_cmd[1] |= ((u64)phys_id) << 32;
> +}
> +
> +static void its_encode_size(struct its_cmd_block *cmd, u8 size)
> +{
> +	cmd->raw_cmd[1] &= ~0x1fUL;
> +	cmd->raw_cmd[1] |= size & 0x1f;
> +}
> +
> +static void its_encode_itt(struct its_cmd_block *cmd, u64 itt_addr)
> +{
> +	cmd->raw_cmd[2] &= ~0xffffffffffffUL;
> +	cmd->raw_cmd[2] |= itt_addr & 0xffffffffff00UL;
> +}
> +
> +static void its_encode_valid(struct its_cmd_block *cmd, int valid)
> +{
> +	cmd->raw_cmd[2] &= ~(1UL << 63);
> +	cmd->raw_cmd[2] |= ((u64)!!valid) << 63;
> +}
> +
> +static void its_encode_target(struct its_cmd_block *cmd, u64 target_addr)
> +{
> +	cmd->raw_cmd[2] &= ~(0xfffffffffUL << 16);
> +	cmd->raw_cmd[2] |= (target_addr & (0xffffffffUL << 16));
> +}
> +
> +static void its_encode_collection(struct its_cmd_block *cmd, u16 col)
> +{
> +	cmd->raw_cmd[2] &= ~0xffffUL;
> +	cmd->raw_cmd[2] |= col;
> +}

The command encoding can be refactored like:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d36f136d57aea6f6440886106e246bb7e5918d8

which will look much clearer.

[...]

> +static void its_send_single_command(its_cmd_builder_t builder,
> +				    struct its_cmd_desc *desc)
> +{
> +	struct its_cmd_block *cmd, *next_cmd;
> +
> +	cmd = its_allocate_entry();
> +	builder(cmd, desc);
> +	next_cmd = its_post_commands();
> +
> +	its_wait_for_range_completion(cmd, next_cmd);
> +}
> +
> +

extra line.

> +static void its_build_mapd_cmd(struct its_cmd_block *cmd,
> +			       struct its_cmd_desc *desc)
> +{
> +	unsigned long itt_addr;
> +	u8 size = 12; /* 4096 eventids */

Maybe use desc->its_mapd_cmd.dev->nr_ites instead as we already have it?

> +
> +	itt_addr = (unsigned long)(virt_to_phys(desc->its_mapd_cmd.dev->itt));
> +	itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);
> +
> +	its_encode_cmd(cmd, GITS_CMD_MAPD);
> +	its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
> +	its_encode_size(cmd, size - 1);
> +	its_encode_itt(cmd, itt_addr);
> +	its_encode_valid(cmd, desc->its_mapd_cmd.valid);
> +	its_fixup_cmd(cmd);
> +	if (desc->verbose)
> +		printf("ITS: MAPD devid=%d size = 0x%x itt=0x%lx valid=%d\n",
> +			desc->its_mapd_cmd.dev->device_id,
> +			size, itt_addr, desc->its_mapd_cmd.valid);
> +

extra line.

All of these are trivial things and feel free to ignore them,
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks


