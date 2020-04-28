Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD630C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B25206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C58Rc60t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B25206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTLyg-00005Y-Hu
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 04:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTLs8-00044q-1m
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTLqn-0001h2-Eu
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:45:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46244
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jTLOr-0000v3-6s
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588061728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYo948iTFo3cvA20W9mJ7xwXsJrswHZGem57WpadW7I=;
 b=C58Rc60tgyFIJ65ph8+6sso54EEj9Uw60W+Ps9y6dPeiktDYjZ4/+tTy37PGwdXuUY0ZJg
 PT4XCfXrMprqxNmTZz+l1Ow5ETs96b6Us+8kEXa5wfZSPPvVEHf1qaqdXkagZJd3TXlI5r
 QxvWjTw+LbDbhfgtVZmytBYKsC1SIik=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-3MUMAM9uN4mdAkWDfFZHow-1; Tue, 28 Apr 2020 04:15:26 -0400
X-MC-Unique: 3MUMAM9uN4mdAkWDfFZHow-1
Received: by mail-wm1-f70.google.com with SMTP id d134so823716wmd.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 01:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bvifb9cPa1q0VEcQEMIVtJdrdDJQ7zqR2f8Kw+S5T/0=;
 b=aiY2kRSM0q5Ij7yAodGCLN9QLOxrRBlIOYjQVGmHOk+nQKDJelzXqQqcU/G23iOuOc
 AfhEBnhNjPV9ZqRsig/dgZxNp8l5tmTe40uK0/0cIm+QtMef6ab77UjPtqF2GNTegNGE
 moyYMMB0ngkgeGAHhHIhxO/McMaDboiSMYBryKUsjQI9xyP8q3X+d3Gfg6gcL3Fjgax1
 Zuy7Dc6yJHXBYm8qr6FXB7UkwcPfowCljdWNefSDWShfzNUUy/ZUTf8uqhG34vhkabta
 +3cYbZxv0ozDxmvoafJYdWPWd+QEDo+98hfoDu35Uc8HLl00WIsniYK7xADI6aJZv8Zb
 fI5A==
X-Gm-Message-State: AGi0PubENJmT+GR+dGt+lDDxmvB6eyEKh11nZbESeubstVw921uxLIj8
 KeN4VD8PMc215ee2UQ3meN5ypA8acPdASccmhCEsNOlyIJX8lFeUC/6WBSzghlgS+IbajeBSD+0
 mV3bq64y3RYRZbi8=
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr3107725wmb.24.1588061725267; 
 Tue, 28 Apr 2020 01:15:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ4fFJ3VxZwdKLJ4Brue+QPumxH7V7CN8xPBpx1LrttvNTUq26yOxthi6ZhN4LgUTiX83ma+g==
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr3107694wmb.24.1588061724973; 
 Tue, 28 Apr 2020 01:15:24 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id q143sm2367308wme.31.2020.04.28.01.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2020 01:15:24 -0700 (PDT)
Subject: Re: [PATCH] hax: Dynamic allocate vcpu state structure
To: Colin Xu <colin.xu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200406070642.3005-1-bowen.wang@intel.com>
 <alpine.LNX.2.22.419.2004201131070.21524@coxu-arch-shz>
 <alpine.LNX.2.22.419.2004281046360.5289@coxu-arch-shz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <74d09ba0-457a-e190-9acd-c19cf78e4d41@redhat.com>
Date: Tue, 28 Apr 2020 10:15:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.22.419.2004281046360.5289@coxu-arch-shz>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: WangBowen <bowen.wang@intel.com>, qemu-devel@nongnu.org,
 wenchao.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 4:47 AM, Colin Xu wrote:
>=20
> And this one. 3 patches for HAX.
>=20
> Thanks in advance.
> --=20
> Best Regards,
> Colin Xu
>=20
> On Mon, 20 Apr 2020, Colin Xu wrote:
>=20
>>
>> Looks good to me.
>>
>> Reviewed-by: Colin Xu <colin.xu@intel.com>
>>
>> --=20
>> Best Regards,
>> Colin Xu
>>
>> On Mon, 6 Apr 2020, WangBowen wrote:
>>
>>> Dynamic allocating vcpu state structure according to smp value to be
>>> more precise and safe. Previously it will alloccate array of fixed size
>>> HAX_MAX_VCPU.
>>>
>>> This is achieved by using g_new0 to dynamic allocate the array. The
>>> allocated size is obtained from smp.max_cpus in MachineState. Also, the
>>> size is compared with HAX_MAX_VCPU when creating the vm. The reason for
>>> choosing dynamic array over linked list is because the status is visite=
d
>>> by index all the time.
>>>
>>> This will lead to QEMU checking whether the smp value is larger than th=
e
>>> HAX_MAX_VCPU when creating vm, if larger, the process will terminate,
>>> otherwise it will allocate array of size smp to store the status.
>>>
>>> Signed-off-by: WangBowen <bowen.wang@intel.com>
>>> ---
>>> target/i386/hax-all.c=A0 | 25 +++++++++++++++++++------
>>> target/i386/hax-i386.h |=A0 5 +++--
>>> 2 files changed, 22 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
>>> index a8b6e5aeb8..a22adec5da 100644
>>> --- a/target/i386/hax-all.c
>>> +++ b/target/i386/hax-all.c
>>> @@ -232,10 +232,10 @@ int hax_init_vcpu(CPUState *cpu)
>>> =A0=A0=A0 return ret;
>>> }
>>>
>>> -struct hax_vm *hax_vm_create(struct hax_state *hax)
>>> +struct hax_vm *hax_vm_create(struct hax_state *hax, int max_cpus)
>>> {
>>> =A0=A0=A0 struct hax_vm *vm;
>>> -=A0=A0=A0 int vm_id =3D 0, ret;
>>> +=A0=A0=A0 int vm_id =3D 0, ret, i;
>>>
>>> =A0=A0=A0 if (hax_invalid_fd(hax->fd)) {
>>> =A0=A0=A0=A0=A0=A0=A0 return NULL;
>>> @@ -259,6 +259,17 @@ struct hax_vm *hax_vm_create(struct hax_state *hax=
)
>>> =A0=A0=A0=A0=A0=A0=A0 goto error;
>>> =A0=A0=A0 }
>>>
>>> +=A0=A0=A0 if (max_cpus > HAX_MAX_VCPU) {
>>> +=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, "Maximum VCPU number QEMU suppor=
ted is=20
>>> %d\n", HAX_MAX_VCPU);
>>> +=A0=A0=A0=A0=A0=A0=A0 goto error;
>>> +=A0=A0=A0 }
>>> +

Move this check before the 'vm =3D g_new0(struct hax_vm, 1);' and simply=20
return NULL, no need to goto error, else you are leaking vm->fd.

>>> +=A0=A0=A0 vm->numvcpus =3D max_cpus;
>>> +=A0=A0=A0 vm->vcpus =3D g_new0(struct hax_vcpu_state *, vm->numvcpus);
>>> +=A0=A0=A0 for (i =3D 0; i < vm->numvcpus; i++) {
>>> +=A0=A0=A0=A0=A0=A0=A0 vm->vcpus[i] =3D NULL;
>>> +=A0=A0=A0 }
>>> +
>>> =A0=A0=A0 hax->vm =3D vm;
>>> =A0=A0=A0 return vm;
>>>
>>> @@ -272,12 +283,14 @@ int hax_vm_destroy(struct hax_vm *vm)
>>> {
>>> =A0=A0=A0 int i;
>>>
>>> -=A0=A0=A0 for (i =3D 0; i < HAX_MAX_VCPU; i++)
>>> +=A0=A0=A0 for (i =3D 0; i < vm->numvcpus; i++)
>>> =A0=A0=A0=A0=A0=A0=A0 if (vm->vcpus[i]) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, "VCPU should be clean=
ed before vm clean\n");
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;
>>> =A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0 hax_close_fd(vm->fd);
>>> +=A0=A0=A0 vm->numvcpus =3D 0;
>>> +=A0=A0=A0 g_free(vm->vcpus);
>>> =A0=A0=A0 g_free(vm);
>>> =A0=A0=A0 hax_global.vm =3D NULL;
>>> =A0=A0=A0 return 0;
>>> @@ -292,7 +305,7 @@ static void hax_handle_interrupt(CPUState *cpu,=20
>>> int mask)
>>> =A0=A0=A0 }
>>> }
>>>
>>> -static int hax_init(ram_addr_t ram_size)
>>> +static int hax_init(ram_addr_t ram_size, int max_cpus)
>>> {
>>> =A0=A0=A0 struct hax_state *hax =3D NULL;
>>> =A0=A0=A0 struct hax_qemu_version qversion;
>>> @@ -324,7 +337,7 @@ static int hax_init(ram_addr_t ram_size)
>>> =A0=A0=A0=A0=A0=A0=A0 goto error;
>>> =A0=A0=A0 }
>>>
>>> -=A0=A0=A0 hax->vm =3D hax_vm_create(hax);
>>> +=A0=A0=A0 hax->vm =3D hax_vm_create(hax, max_cpus);
>>> =A0=A0=A0 if (!hax->vm) {
>>> =A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, "Failed to create HAX VM\n");
>>> =A0=A0=A0=A0=A0=A0=A0 ret =3D -EINVAL;
>>> @@ -352,7 +365,7 @@ static int hax_init(ram_addr_t ram_size)
>>>
>>> static int hax_accel_init(MachineState *ms)
>>> {
>>> -=A0=A0=A0 int ret =3D hax_init(ms->ram_size);
>>> +=A0=A0=A0 int ret =3D hax_init(ms->ram_size, (int)ms->smp.max_cpus);
>>>
>>> =A0=A0=A0 if (ret && (ret !=3D -ENOSPC)) {
>>> =A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, "No accelerator found.\n");
>>> diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
>>> index 54e9d8b057..7d988f81da 100644
>>> --- a/target/i386/hax-i386.h
>>> +++ b/target/i386/hax-i386.h
>>> @@ -47,7 +47,8 @@ struct hax_state {
>>> struct hax_vm {
>>> =A0=A0=A0 hax_fd fd;
>>> =A0=A0=A0 int id;
>>> -=A0=A0=A0 struct hax_vcpu_state *vcpus[HAX_MAX_VCPU];
>>> +=A0=A0=A0 int numvcpus;
>>> +=A0=A0=A0 struct hax_vcpu_state **vcpus;
>>> };
>>>
>>> #ifdef NEED_CPU_H
>>> @@ -58,7 +59,7 @@ int valid_hax_tunnel_size(uint16_t size);
>>> /* Host specific functions */
>>> int hax_mod_version(struct hax_state *hax, struct hax_module_version=20
>>> *version);
>>> int hax_inject_interrupt(CPUArchState *env, int vector);
>>> -struct hax_vm *hax_vm_create(struct hax_state *hax);
>>> +struct hax_vm *hax_vm_create(struct hax_state *hax, int max_cpus);
>>> int hax_vcpu_run(struct hax_vcpu_state *vcpu);
>>> int hax_vcpu_create(int id);
>>> int hax_sync_vcpu_state(CPUArchState *env, struct vcpu_state_t *state,
>>> --=20
>>> 2.24.1
>>>
>>>
>>
>=20


