Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E54C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 11:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F68820772
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 11:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1g/9K2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F68820772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgRoX-0001TC-I1
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 07:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgRnf-0000oJ-W7
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 07:43:16 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgRne-0001vj-OO
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 07:43:15 -0400
Received: by mail-wm1-x343.google.com with SMTP id r15so1690088wmh.5
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9cNyr4SulKdBbZQdmwAyGDYZT9WTZ283YKlLj6AJTNQ=;
 b=J1g/9K2I5ZOOUgirfyrTtfX40qKSe8DGFk5qdWB+qJbyA91Btxn2sikuoiIYglplpd
 7Qn91YjES0/dTdOrLTl3yoJK6fbO/AZfS1YIoORLcARMFNcla5aBf2OghTvSed4f6y1x
 xLbm4vUOWCSFpoTyFnfADL7vo2Xzj8lKQWf1CGtisH/zQZQ0GxSMBe1tQlNNH6PDJ9IZ
 WQTjLu8CKzxW5LjfzG9dfiOh0QtrbYTREb98iLCVm8UU3To/65/nGxanmO20w9TalovY
 oURrA6GT+icct3ml0lC6wtVCm+Gny+1upjpYAIze+BCtoEBEq343tHwpOpWegkRot6Ie
 jU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9cNyr4SulKdBbZQdmwAyGDYZT9WTZ283YKlLj6AJTNQ=;
 b=RLkdpUK3qQ4UUmEL/FejNPf7Mx6ggCz9O3qdcamntILdHJzBgKDyDJ+9a4Bschzjbg
 jkSEbpFjilv5J3huM0AqS6DUGjhe0p7cGxQnoE++OkK0ORtRL5pknQqr8feOMoN9RLYO
 4D10or7/jCB5M5PFxO5e2L595llyQhtQOk78QeCU4hoDMC3oaowuandV7OfBItd2cYpu
 FpHfFJKoZpZEsu0/7nlM9QgMbI+zoZWvLG1Rlp1wp3Xzhq7TDSqoQ4uSoG/6vu44pH/s
 tZ7Z8IvoX5ecQFhtSSAox1XFkZWYYuerpxIxaJSy/vJCsASaZJ6TmkNBHp8Le1VbSksY
 NYpw==
X-Gm-Message-State: AOAM531U3sNJHCB3t/QgtZx0r/7mw0hH1s3yjoUpQOcSIR+cYX2Qju5F
 xqEfybRBfufPGZZP9ME/TE1pgA==
X-Google-Smtp-Source: ABdhPJzG+kYqLQne+8c8opQR3+R1GYtcMmuVlNFgBl67RzemkRQ/PptzmcABudLNbRBh3Pu7bYjzqw==
X-Received: by 2002:a1c:c1:: with SMTP id 184mr8295749wma.74.1591184592399;
 Wed, 03 Jun 2020 04:43:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e12sm1916377wro.52.2020.06.03.04.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 04:43:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3D95D1FF7E;
 Wed,  3 Jun 2020 12:43:10 +0100 (BST)
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-9-alex.bennee@linaro.org>
 <CAEyhzFvTF7Sh1ugq_O9CwADf3LmkWjdCHqmafQC0wkDMKQH1=A@mail.gmail.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 8/9] plugins: new hwprofile plugin
In-reply-to: <CAEyhzFvTF7Sh1ugq_O9CwADf3LmkWjdCHqmafQC0wkDMKQH1=A@mail.gmail.com>
Date: Wed, 03 Jun 2020 12:43:10 +0100
Message-ID: <87sgfc5q9d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, "Emilio G. Cota" <cota@braap.org>,
 kuhn.chenqun@huawei.com, Peter Puhov <peter.puhov@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Hi,
>
> On Tue, 2 Jun 2020 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> <snip>
>> diff --git a/tests/plugin/hwprofile.c b/tests/plugin/hwprofile.c
>> new file mode 100644
>> index 00000000000..f5e0639e762
>> --- /dev/null
>> +++ b/tests/plugin/hwprofile.c
> <snip>
>> +static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t me=
minfo,
>> +                       uint64_t vaddr, void *udata)
>> +{
>> +    struct qemu_plugin_hwaddr *hwaddr =3D qemu_plugin_get_hwaddr(meminf=
o, vaddr);
>> +
>> +    if (!hwaddr || !qemu_plugin_hwaddr_is_io(hwaddr)) {
>> +        return;
>> +    } else {
>> +        char *name =3D qemu_plugin_hwaddr_device_name(hwaddr);
>> +        DeviceCounts *counts;
>> +
>> +        g_mutex_lock(&lock);
>> +        counts =3D (DeviceCounts *) g_hash_table_lookup(devices, name);
>> +        if (!counts) {
>> +            uint64_t off =3D qemu_plugin_hwaddr_device_offset(hwaddr);
>> +            uint64_t base =3D vaddr - off;
>> +            counts =3D new_count(name, base);
>> +        } else {
>> +            g_free(name);
>> +        }
>> +
>> +        if (detail) {
>> +            uint64_t off =3D qemu_plugin_hwaddr_device_offset(hwaddr);
>> +            IOLocationCounts *io_count =3D g_hash_table_lookup(counts->=
access_pattern, &off);
>> +            if (!io_count) {
>> +                io_count =3D new_location(off);
>> +                g_hash_table_insert(counts->access_pattern, &off, io_co=
unt);
>> +            }
>> +            if (qemu_plugin_mem_is_store(meminfo)) {
>> +                io_count->writes++;
>> +                io_count->cpu_write |=3D (1 << cpu_index);
>> +            } else {
>> +                io_count->reads++;
>> +                io_count->cpu_read |=3D (1 << cpu_index);
>> +            }
>> +        } else {
>> +            if (qemu_plugin_mem_is_store(meminfo)) {
>> +                counts->total_writes++;
>> +                counts->cpu_write |=3D (1 << cpu_index);
>> +            } else {
>> +                counts->total_reads++;
>> +                counts->cpu_read |=3D (1 << cpu_index);
>
> The bitmasks cpu_read and cpu_write are ints.  Maybe to account for
> larger core counts

I could make them uint64_t and then just warn if we exceed that on start-up.

>> 32, we could assert if the cpu_index is >=3D 32?
>
>> +            }
>> +        }
>> +        g_mutex_unlock(&lock);
>> +    }
>> +}
>> +
>> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *t=
b)
>> +{
>> +    size_t n =3D qemu_plugin_tb_n_insns(tb);
>> +    size_t i;
>> +
>> +    for (i =3D 0; i < n; i++) {
>> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i=
);
>> +        qemu_plugin_register_vcpu_mem_cb(insn, vcpu_haddr,
>> +                                         QEMU_PLUGIN_CB_NO_REGS,
>> +                                         rw, NULL);
>> +    }
>> +}
>> +
>> +QEMU_PLUGIN_EXPORT
>> +int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
>> +                        int argc, char **argv)
>> +{
>> +    int i;
>> +
>> +    for (i =3D 0; i < argc; i++) {
>> +        char *opt =3D argv[i];
>> +        if (g_strcmp0(opt, "read") =3D=3D 0) {
>> +            rw =3D QEMU_PLUGIN_MEM_R;
>> +        } else if (g_strcmp0(opt, "write") =3D=3D 0) {
>> +            rw =3D QEMU_PLUGIN_MEM_W;
>> +        } else if (g_strcmp0(opt, "detail") =3D=3D 0) {
>
> When testing out the options, I noticed that
> if we supply arguments of "read", and "write", then we will only get
> the last one set, "write", since rw gets overwritten.
> One option would be to error out if more than one of these read/write
> args is supplied.

Yeah the option parsing is a little clunky although given the way you
pass them from the QEMU command line perhaps not too worth finessing.
The default is rw so you make a conscious decision to only care about one
or the other.

All you can really do is fail to initialise the plugin. Hopefully the
output should be enough clue.

>
> Reviewed-by: Robert Foley <robert.foley@linaro.org>
> Tested-by: Robert Foley <robert.foley@linaro.org>

Thanks.

Out of interest what did you measure? Are there any useful use cases you can
think of?

>
>> +            detail =3D true;
>> +        } else {
>> +            fprintf(stderr, "option parsing failed: %s\n", opt);
>> +            return -1;
>> +        }
>> +    }
>> +
>> +    plugin_init();
>> +
>> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>> +    return 0;
>> +}
>> diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
>> index b3250e2504c..d87b8d40699 100644
>> --- a/tests/plugin/Makefile
>> +++ b/tests/plugin/Makefile
>> @@ -14,6 +14,7 @@ NAMES +=3D hotblocks
>>  NAMES +=3D howvec
>>  NAMES +=3D hotpages
>>  NAMES +=3D lockstep
>> +NAMES +=3D hwprofile
>>
>>  SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
>>
>> --
>> 2.20.1
>>


--=20
Alex Benn=C3=A9e

