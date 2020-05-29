Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A369C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 19:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29CE207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 19:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XQ97t6Bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29CE207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jekcS-00009c-Un
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 15:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1jekbe-00089H-FL
 for qemu-devel@nongnu.org; Fri, 29 May 2020 15:23:50 -0400
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com
 ([40.107.236.78]:19555 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1jekbd-0000B1-2K
 for qemu-devel@nongnu.org; Fri, 29 May 2020 15:23:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcdOcHBg6O8HVZ3AQ07kQh7rNWXkjm92Zi4fbHuWy8Y95Cao/iw96UyUeaHBs1M6AT8UbXDwaP7CVtdB3oZAZIqIvjmp+O5ZnDVhF/Y7kPi31jhgUwN0dBmHlaaJtTxPakL9AMVY4gXABndt1NlFtej4ccy/BlewHcyHwgkjsdU9JZHpbxz1tEgBpKY1CWrFj3KXEEUBvzA1cWf/Ah8zHzT6jTQyA7DfsPeS9PF0OEOm3eJrosRwjx6ONNZ1qZfXP3h8IDfqa/m8xVif2jw0GeCtf/XKzIjz2weB0x0pkmm077exf55/Gc82gT3vPqhvEFXmopi/5G60N8ZPFGoy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5nrEOuVGjTcJAJvUnzlMg3F8ngwWr0XKHlAKI+ymlk=;
 b=egckA9bOmLMZ85BqTJayRhLZiXF3CHfUWcfkcX1xMOKy9hk8rByIqebV3I2FXhJTh+GHrQDLuRsUnTXq2k7lmuRwXUWuLypGOxT+R2ASIQGl1QnPujG/Hu0s/zN0otNHNV2YCpHZ7FxetYBIf3UQrX282FtkvZv/JRWHoiMy0PugVXxnOrpIYa5GUesHpktlul227MF5iJh2N31mw45iU5yKxCzr0Zj/bRATWlQq/BsdER2tv3UAwh6fbbEbkzDr1KKC++QF2H6WPpgsT7//d5dpjRgY7SPf7tT8+xYdlGEQbKPK9hyy/dqvPmN2facAVGA8nmmh5NnS/N1lRCxUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5nrEOuVGjTcJAJvUnzlMg3F8ngwWr0XKHlAKI+ymlk=;
 b=XQ97t6BptQ7KT3Wy81WBg1DPwN8awwav5wdULUVKB2Cl3ZAFFBpCjYbe5YAiueREvpzFyQYRaGiPaQ6sHmYfrKbnyYeedlu2qTAb3b3TWZBBC9Y5zkQ4alw+59wxLuJonRk2MnwMr9EJUaJtiz4F121VBR/0ntgtaXP5t3clDRA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB1321.namprd12.prod.outlook.com (2603:10b6:3:78::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.27; Fri, 29 May 2020 19:08:43 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::4ce1:9947:9681:c8b1]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::4ce1:9947:9681:c8b1%10]) with mapi id 15.20.3021.030; Fri, 29 May
 2020 19:08:43 +0000
Subject: Re: [PATCH 2/2] sev: scan guest ROM for launch secret address
To: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>, jejb@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20200528205114.42078-1-tobin@linux.vnet.ibm.com>
 <20200528205114.42078-3-tobin@linux.vnet.ibm.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <c40c2f7c-3506-2827-9420-0a78ffaa6460@amd.com>
Date: Fri, 29 May 2020 14:08:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200528205114.42078-3-tobin@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0120.namprd05.prod.outlook.com
 (2603:10b6:803:42::37) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by
 SN4PR0501CA0120.namprd05.prod.outlook.com (2603:10b6:803:42::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.8 via Frontend
 Transport; Fri, 29 May 2020 19:08:42 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bfa34373-f557-43b1-9126-08d80403b42e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1321:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13212AE20D3BBC3AAC835CFBEC8F0@DM5PR12MB1321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8dZkuoheR9vGgCcslXB52ALvX3L+Y0goDmu6a7Lp+MH2IyAd7AfRkvCjVnFu62PyHQd0HoxwvGZSgh/rzAp6FphYVprDpZ/n5lTK1tsIX+K40wJybFqltLE9Ju9MTrewO/fLByIuZ+b+I8meYmiEOK/DQW/kRfJFid17UqNrEVYpQSj0KvIw+JnIawh70UXIA4R8aHLQte0SQlF1BSbhHC3Cp8BSUiShUASrzWTBYqF9ad9CMSPxq+Iquq2EG14Au9276ynj/UWNwm8YSuUmY2YTvZv5xq8oa4ClLQbAIBOxdoV65DVj3vHw9uLVvBK+CkBl55zS386461uIS0tcyfgdwVmgocB7Nq8pF2KQIGXaBlBLkReUEIQC+5kznvVreEMMui69C2Ce9NSYXp3ZTonWOS5mRfOF26mrFCt2CZDeVSKclEj5iwczc0tIMu6cdZjjny1umwt40XqY+QXkgy8B384qJkREM+0epTY4/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(4326008)(31696002)(2906002)(6512007)(66946007)(66556008)(16526019)(6506007)(66476007)(316002)(956004)(26005)(2616005)(186003)(53546011)(52116002)(5660300002)(478600001)(966005)(36756003)(86362001)(6486002)(31686004)(8936002)(83380400001)(8676002)(219293001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JJufGNbc3wOyUifOOdrJpS+Yb3jbi5YgEhaSinnFvv8OoxZOGnK0Cfrax6hgTJRB2CMBxO/uMtrY6/tNdvKY2oi/biETDU0cWISBvpKqt5ibYrS8r4dVIm3vQ3+8ecLrK+jJj1pPU+Fr7Obm79ZU4lhP0tZkUfxG3VBWNrsgWxO23SSuavK0SGmyJjaH+IMlbLleDCVMsqGIH4znYVYdOkNezacWP7pJg1HEM3eEKEraqHLLXWsU84UVUZ8BblDM4f6pghSkJ2xY0vEvAm8iO20r42y7CACPs4IHsMCFBalYhy4psR5qqNXkwBFlpCcF6SZzcZ+kOn+romJQct5FmQbGzggHHUg2WMD6PfvDAY+Em/zKWdL1lq89WXtob5u7HGe2opL6ZWUBpNiCbuFRuqaYn7WsEx87EX515hJb+bOiqG5SQLgLLPMsbzk3BMn4/S/k7veiqd5DGNxWXDVoFfdW4z1QQ5i9dV8QIhxsrTCaiJY/SOriqPK4qf74QKA5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa34373-f557-43b1-9126-08d80403b42e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 19:08:43.2356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uIvWZdX6fX0FdP5xiNmtlw+RQncXagb9gbNzwvL67TY5rW/wUx/q6mUGA1krbfZTpngSHkhdh82v5pO0C7qXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1321
Received-SPF: none client-ip=40.107.236.78;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 15:23:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Brijesh Singh <brijesh.singh@amd.com>, tobin@ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 3:51 PM, Tobin Feldman-Fitzthum wrote:
> From: Tobin Feldman-Fitzthum <tobin@ibm.com>
> 
> In addition to using QMP to provide the guest memory address
> that the launch secret blob will be injected into, the
> secret address can also be specified in the guest ROM. This
> patch adds sev_find_secret_gpa, which scans the ROM page by
> page to find a launch secret table identified by a GUID. If
> the table is found, the address it contains will be used
> in place of any address specified via QMP.

I'm working on something similar for SEV-ES support in OVMF (see 
https://www.mail-archive.com/devel@edk2.groups.io/msg20716.html). The GUID 
is placed at a fixed location from the end of the ROM. One of the OVMF 
maintainers recommended the approach and I think we should work to support 
the guest LAUNCH SECRET GPA using the same GUID. This particular patch 
should be delayed until an OVMF method is accepted, so that it doesn't 
have to be reworked.

Thanks,
Tom

> 
> Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
> ---
>   target/i386/sev.c      | 34 ++++++++++++++++++++++++++++++++--
>   target/i386/sev_i386.h | 16 ++++++++++++++++
>   2 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 774e47d9d1..4adc56d7e3 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -706,6 +706,8 @@ sev_guest_init(const char *id)
>       s->api_major = status.api_major;
>       s->api_minor = status.api_minor;
>   
> +    s->secret_gpa = 0;
> +
>       trace_kvm_sev_init();
>       ret = sev_ioctl(s->sev_fd, KVM_SEV_INIT, NULL, &fw_error);
>       if (ret) {
> @@ -731,6 +733,28 @@ err:
>       return NULL;
>   }
>   
> +static void
> +sev_find_secret_gpa(uint8_t *ptr, uint64_t len)
> +{
> +    uint64_t offset;
> +
> +    SevROMSecretTable *secret_table;
> +    QemuUUID secret_table_guid;
> +
> +    qemu_uuid_parse(SEV_ROM_SECRET_GUID,&secret_table_guid);
> +    secret_table_guid = qemu_uuid_bswap(secret_table_guid);
> +
> +    offset = len - 0x1000;
> +    while(offset > 0) {
> +        secret_table = (SevROMSecretTable *)(ptr + offset);
> +        if(qemu_uuid_is_equal(&secret_table_guid, (QemuUUID *) secret_table)){
> +            sev_state->secret_gpa = (long unsigned int) secret_table->base;
> +            break;
> +        }
> +        offset -= 0x1000;
> +    }
> +}
> +
>   int
>   sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
>   {
> @@ -738,6 +762,9 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
>   
>       /* if SEV is in update state then encrypt the data else do nothing */
>       if (sev_check_state(SEV_STATE_LAUNCH_UPDATE)) {
> +        if(!sev_state->secret_gpa) {
> +            sev_find_secret_gpa(ptr, len);
> +	    }
>           return sev_launch_update_data(ptr, len);
>       }
>   
> @@ -776,8 +803,8 @@ int sev_inject_launch_secret(const char *packet_hdr,
>   
>       /* secret can be inject only in this state */
>       if (!sev_check_state(SEV_STATE_LAUNCH_SECRET)) {
> -	error_report("Not in correct state. %x",sev_state->state);
> -	return 1;
> +        error_report("Not in correct state. %x",sev_state->state);
> +        return 1;
>       }
>   
>       hdr = g_base64_decode(packet_hdr, &hdr_sz);
> @@ -792,6 +819,9 @@ int sev_inject_launch_secret(const char *packet_hdr,
>           goto err;
>       }
>   
> +    if(sev_state->secret_gpa)
> +        gpa = sev_state->secret_gpa;
> +
>       hva = gpa2hva(gpa, data_sz);
>       if (!hva) {
>           goto err;
> diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
> index 8ada9d385d..b1f9ab93bb 100644
> --- a/target/i386/sev_i386.h
> +++ b/target/i386/sev_i386.h
> @@ -19,6 +19,7 @@
>   #include "sysemu/kvm.h"
>   #include "sysemu/sev.h"
>   #include "qemu/error-report.h"
> +#include "qemu/uuid.h"
>   #include "qapi/qapi-types-misc-target.h"
>   
>   #define SEV_POLICY_NODBG        0x1
> @@ -28,6 +29,8 @@
>   #define SEV_POLICY_DOMAIN       0x10
>   #define SEV_POLICY_SEV          0x20
>   
> +#define SEV_ROM_SECRET_GUID "adf956ad-e98c-484c-ae11-b51c7d336447"
> +
>   #define TYPE_QSEV_GUEST_INFO "sev-guest"
>   #define QSEV_GUEST_INFO(obj)                  \
>       OBJECT_CHECK(QSevGuestInfo, (obj), TYPE_QSEV_GUEST_INFO)
> @@ -42,6 +45,18 @@ extern SevCapability *sev_get_capabilities(void);
>   
>   typedef struct QSevGuestInfo QSevGuestInfo;
>   typedef struct QSevGuestInfoClass QSevGuestInfoClass;
> +typedef struct SevROMSecretTable SevROMSecretTable;
> +
> +/**
> + * If guest physical address for the launch secret is
> + * provided in the ROM, it should be in the following
> + * page-aligned structure.
> + */
> +struct SevROMSecretTable {
> +    QemuUUID guid;
> +    unsigned int base;
> +    unsigned int size;
> +};
>   
>   /**
>    * QSevGuestInfo:
> @@ -78,6 +93,7 @@ struct SEVState {
>       uint32_t cbitpos;
>       uint32_t reduced_phys_bits;
>       uint32_t handle;
> +    uint64_t secret_gpa;
>       int sev_fd;
>       SevState state;
>       gchar *measurement;
> 

