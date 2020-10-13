Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD30DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042E220709
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042E220709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEUF-0000kZ-TD
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSET8-00007n-Qk; Tue, 13 Oct 2020 03:11:34 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSET6-0002RX-U5; Tue, 13 Oct 2020 03:11:34 -0400
Received: from [192.168.100.1] ([82.252.141.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mq2rM-1k6w9L0WHK-00n5OB; Tue, 13 Oct 2020 09:11:05 +0200
Subject: Re: [PATCH] migration/block-dirty-bitmap: fix uninitialized variable
 warning
To: Li Qiang <liq3ea@gmail.com>
References: <20201010110730.1575180-1-kuhn.chenqun@huawei.com>
 <2b2bc826-0785-66e2-3515-b98abfac26ca@vivier.eu>
 <CAKXe6SL8fRN=-iqFEiHeWqZm0F+T+8vkc7qJeUz6izQcZQ2Q-A@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <70bc9735-6555-078a-52da-61da6c58f1d3@vivier.eu>
Date: Tue, 13 Oct 2020 09:11:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SL8fRN=-iqFEiHeWqZm0F+T+8vkc7qJeUz6izQcZQ2Q-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:glXmnJ0ZnbqQBabudNTkN8a2amlWLDkcy7SV83KO2GtAkNrFn2n
 Th3tQqkBhGKwxBmSLGP4DP0o+RkyOktbqNA+THEKTupumHRnaiyH5U8h0vQq4bI3RbD0h1q
 h/uNXz2+ChvbR0OJVCXvixeL54xrDMkbRPG71vqF5BYXFO8dZ/seqTf1E8mb0i/ZI2oxmlY
 d3amCGudrIka2HgcyCJCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fODdjLjnMDE=:36CWtcTsvlZ/yLO5w/wOUJ
 J2ZDQHqbixefk7NpM4iC6TXsSOeMr2+QRevI5DUp+A7AeRZa/RPLzql59RnJUhKpHCXq0oJ5R
 4zYd0tFiH31ozyxCUAxVCxq7ReV/R40IDvobM2bnwvP8qlwXnCZ2omM2PFFZtuZWI2FA8U2q6
 2bC2Mmj+i5scCsRZj+IpQtLCRJwxV60TNwFey/i+4kgH84j3t8XIvEfizsti7mogLqOuMGT36
 uIauhKX7CQ/kKLUrhuGqlQ7FC9U+RuaKbMU/CptfMj1TIAavNjneEkzX5UgQkz3rvyagGereI
 XsLoCbpHK/SWfqYYX0K2p64YHX25rGoIuedrCKa/sdkxQBJGpNiTDVTv5q55GosJGejzq52bR
 xG56bEcb/i/8DKpGNEoUaQxQsCqxF8H5KkCZa5Ra0St68uj5zUVZ1j7l/PvnQe4eRTBufRYEh
 8hj7J5b7yPfHSmGdRMCeSznKS1NRIxo7EDucV8x0hAODEfENczHfJ5enEK+tkWVmVzvjVa7CZ
 iO5xHyIV69/Ta1uRA6T5dXiubYc40cqPVmtDDbs/08NQkTu+NM0RpvwlbcImnxnXcpVm8sF8t
 tol1Dy43VjlARB1mpUskkrTDSfeERXUj0guh++85jYAvr5ElsT1ULZwXBvUZDvUU3faNeJKu/
 0l5giBkN8OXd/606IjuUcWxHHb7ZkY/Zy2Ikdr9oqgH5zb2gvabPtGrxfsFHoJ7PRkpAy6PDw
 6NZYuvsuAbYm+ebkgic9jMxtG83ZnspxZswsO8TYSye7uRFs3YIBh5tWYyUf+Bo/PK+v81mg2
 LAA2c5uzTl4YCjvE3yYgbcOdI6eHuxFVfK15SYLr5TcA4Eo2NsesCXwToY53SsoeBZ6v9+g
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:11:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/10/2020 à 03:34, Li Qiang a écrit :
> Laurent Vivier <laurent@vivier.eu> 于2020年10月12日周一 下午11:33写道：
>>
>> Le 10/10/2020 à 13:07, Chen Qun a écrit :
>>> This if statement judgment is redundant and it will cause a warning:
>>>
>>> migration/block-dirty-bitmap.c:1090:13: warning: ‘bitmap_name’ may be used
>>>  uninitialized in this function [-Wmaybe-uninitialized]
>>>              g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name));
>>>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>>> ---
>>>  migration/block-dirty-bitmap.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>>> index 5bef793ac0..e09ea4f22b 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -1084,9 +1084,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
>>>              } else {
>>>                  bitmap_name = s->bitmap_alias;
>>>              }
>>> -        }
>>>
>>> -        if (!s->cancelled) {
>>>              g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name));
>>>              s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
>>>
>>>
>>
>> I don't think it's correct as "cancel_incoming_locked(s)" can change the
>> value of "s->cancelled".
>>
> 
> Hi Laurent,
> 
> You're right. So I think this can simply assign 'bitmap_name' to NULL
> to make compiler happy.

Yes, and adding a comment before the second "if (!s->cancelled) {" to
explain the value can be changed by "cancel_incoming_locked(s)" would
avoid to have this kind of patch posted regularly to the ML.

Thanks,
Laurent


