Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB28C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E3D24692
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mqt2PMZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E3D24692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7OUf-0003W2-H8
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 14:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7OTh-0002zj-Fi
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7OTf-0000RR-TX
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:05:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37678
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7OTf-0000JM-Q1
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582830339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGVK2F/TbfEDqN5cBRyE0/Hj1kZbg9bBmRRH8RAbREc=;
 b=Mqt2PMZ3e0vJBJ22V71cHzDbUGVlpCQymLhPyxaF/Ufn4/FZf2iKaT4XGLng4YSJWwl19h
 lKd6dPJZD2SoingFL/R12hHLsDSABl7qBymzCvgMct25CeNX09AIfzaR7xfFh/9hmzGi8T
 72kdo7O3Hd07olg3oKIBbFiOycxEUWc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-3oAUzvs0NRaUit4DnEkkug-1; Thu, 27 Feb 2020 14:05:37 -0500
X-MC-Unique: 3oAUzvs0NRaUit4DnEkkug-1
Received: by mail-wr1-f72.google.com with SMTP id p5so221287wrj.17
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 11:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+KT/FCOzM7vqW8m0x1I3CaHhfRz4Fup2MyNkoVNC+xg=;
 b=I7gyfC7BkzaMcgO+TwGVxPEMMR12geI3Qcr+CWckyrjM5Ms1KLgHqi5xE4n2pcWG7q
 tj1p5Wp9X+i8/6BEKJoFojYnJP5imdoWlhPBhs0ys9BwQOiodbDKc2B3scmPj7m746fl
 I88DNwP1JFouLDBHjeH3RLqRYNRKO5sKgk3vpfQ+zmvQOp3U3StiW5GbCt9YdkBlugCT
 Nko+FcH0+RX+DW1tVQD3sl4e/ds/Avc3Szq2p2CeL33SR9C9iR9wLmggsCb1tBzrJsg6
 DFOIXKGIuZEyQCAjkiGhOMhtZnmq5QnEZ6XKEjbUBSN1VDYkS0DOBzrZBfI2KXxyMf/V
 3a4Q==
X-Gm-Message-State: APjAAAXbZO77XUJm28lKKs6aBVH15iQKxIhfTbZSRRu5VjpgqAKINMP8
 XWiVQufMBFzbzjmDdxzAAmr2vMvh+zaVLR7qS7OLmUzyZ2lowxCB4VSERfH7ft4QRMYP7Xw7HVd
 M14c+BOTMfjOBtBU=
X-Received: by 2002:adf:eac1:: with SMTP id o1mr308405wrn.234.1582830336582;
 Thu, 27 Feb 2020 11:05:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjQrBYg2rDlZrzW7VHPNhpDfL1Sai1e0nKm9bwTm8WYD10D5XD5uam/q/K2u2qP9r7pf/e9A==
X-Received: by 2002:adf:eac1:: with SMTP id o1mr308383wrn.234.1582830336364;
 Thu, 27 Feb 2020 11:05:36 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id m22sm7899123wmc.41.2020.02.27.11.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 11:05:35 -0800 (PST)
Subject: Re: [PATCH] migration/savevm: release gslist after dump_vmstate_json
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, pannengyuan@huawei.com
References: <20200219094705.8960-1-pannengyuan@huawei.com>
 <20200219095908.GB3089@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6dbc9a44-0e99-266b-11b6-d4f5b5fdb285@redhat.com>
Date: Thu, 27 Feb 2020 20:05:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219095908.GB3089@work-vm>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: quintela@redhat.com, zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/19/20 10:59 AM, Dr. David Alan Gilbert wrote:
> * pannengyuan@huawei.com (pannengyuan@huawei.com) wrote:
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> 'list' forgot to free at the end of dump_vmstate_json_to_file(), althoug=
h it's called only once, but seems like a clean code.
>>
>> Fix the leak as follow:
>> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>>      #0 0x7fb946abd768 in __interceptor_malloc (/lib64/libasan.so.5+0xef=
768)
>>      #1 0x7fb945eca445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>>      #2 0x7fb945ee2066 in g_slice_alloc (/lib64/libglib-2.0.so.0+0x6a066=
)
>>      #3 0x7fb945ee3139 in g_slist_prepend (/lib64/libglib-2.0.so.0+0x6b1=
39)
>>      #4 0x5585db591581 in object_class_get_list_tramp /mnt/sdb/qemu-new/=
qemu/qom/object.c:1084
>>      #5 0x5585db590f66 in object_class_foreach_tramp /mnt/sdb/qemu-new/q=
emu/qom/object.c:1028
>>      #6 0x7fb945eb35f7 in g_hash_table_foreach (/lib64/libglib-2.0.so.0+=
0x3b5f7)
>>      #7 0x5585db59110c in object_class_foreach /mnt/sdb/qemu-new/qemu/qo=
m/object.c:1038
>>      #8 0x5585db5916b6 in object_class_get_list /mnt/sdb/qemu-new/qemu/q=
om/object.c:1092
>>      #9 0x5585db335ca0 in dump_vmstate_json_to_file /mnt/sdb/qemu-new/qe=
mu/migration/savevm.c:638
>>      #10 0x5585daa5bcbf in main /mnt/sdb/qemu-new/qemu/vl.c:4420
>>      #11 0x7fb941204812 in __libc_start_main ../csu/libc-start.c:308
>>      #12 0x5585da29420d in _start (/mnt/sdb/qemu-new/qemu/build/x86_64-s=
oftmmu/qemu-system-x86_64+0x27f020d)
>>
>> Indirect leak of 7472 byte(s) in 467 object(s) allocated from:
>>      #0 0x7fb946abd768 in __interceptor_malloc (/lib64/libasan.so.5+0xef=
768)
>>      #1 0x7fb945eca445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>>      #2 0x7fb945ee2066 in g_slice_alloc (/lib64/libglib-2.0.so.0+0x6a066=
)
>>      #3 0x7fb945ee3139 in g_slist_prepend (/lib64/libglib-2.0.so.0+0x6b1=
39)
>>      #4 0x5585db591581 in object_class_get_list_tramp /mnt/sdb/qemu-new/=
qemu/qom/object.c:1084
>>      #5 0x5585db590f66 in object_class_foreach_tramp /mnt/sdb/qemu-new/q=
emu/qom/object.c:1028
>>      #6 0x7fb945eb35f7 in g_hash_table_foreach (/lib64/libglib-2.0.so.0+=
0x3b5f7)
>>      #7 0x5585db59110c in object_class_foreach /mnt/sdb/qemu-new/qemu/qo=
m/object.c:1038
>>      #8 0x5585db5916b6 in object_class_get_list /mnt/sdb/qemu-new/qemu/q=
om/object.c:1092
>>      #9 0x5585db335ca0 in dump_vmstate_json_to_file /mnt/sdb/qemu-new/qe=
mu/migration/savevm.c:638
>>      #10 0x5585daa5bcbf in main /mnt/sdb/qemu-new/qemu/vl.c:4420
>>      #11 0x7fb941204812 in __libc_start_main ../csu/libc-start.c:308
>>      #12 0x5585da29420d in _start (/mnt/sdb/qemu-new/qemu/build/x86_64-s=
oftmmu/qemu-system-x86_64+0x27f020d)
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>=20
> Good robot!

Unfortunately it doesn't generate the documentation along...

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>>   migration/savevm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index f19cb9ec7a..60e6ea8a8d 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -665,6 +665,7 @@ void dump_vmstate_json_to_file(FILE *out_file)
>>       }
>>       fprintf(out_file, "\n}\n");
>>       fclose(out_file);
>> +    g_slist_free(list);
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
>>   }
>>  =20
>>   static uint32_t calculate_new_instance_id(const char *idstr)
>> --=20
>> 2.18.2
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20


