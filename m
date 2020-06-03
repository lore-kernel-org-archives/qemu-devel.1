Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021E3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABBB20678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l02zR06f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABBB20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgSiB-00027r-0z
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 08:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgShR-0001Fj-U9
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 08:40:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgShR-00076h-7E
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 08:40:53 -0400
Received: by mail-wm1-x344.google.com with SMTP id r9so1779026wmh.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5VWXnlAvFTozn+Qjv+aQSs3J1xLmhPNMl7lS1SpUHrA=;
 b=l02zR06f507ucS8qBzmhKbG9XBT+4G+oEyeijuuEkR//zDUN/GM43be77uHC2RWs2t
 APGtFfsCsortqUK13/16FGd4Y2PoKHlzp1Q1/m3TOIIZ9C6HUClrm30UDJoGGjli47WG
 +Tz5L1nQGWldQsA+g6OhGUn6Mx2b2PU+ZdYbNtEPQSy+6wW9xsHjtahMZVsSYpPdTvYL
 Do7vZqhmEZh6O7i86WiIw5/p9KJHHefnWakzBo2kxinfDssWgxYZVpReumFky9pSuUXq
 Uyn+4Ps34AAazXgr44zPypHt6BW5L2SU5D5mQKuwuLs55D0Q/XZbIdy54q6nKB0nQXOY
 cC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5VWXnlAvFTozn+Qjv+aQSs3J1xLmhPNMl7lS1SpUHrA=;
 b=PAKzKioXUEBr5K7ljzarsEWh0r+2qvWeqDIk4O+KC+LJ9syAqdP/mamWiq6ZQ4LeYC
 9Mj1KvRGD6WdPN8ZrDx5p2UPKIootxzC2gF3R9QsOoIMbwKBJc8IJhUJuksnl00AOAUp
 7p/iBElD/Lnv7BHL1AJgnq4SiLS1z5XiCKKV5vw20IN/6Cq9ORlicDDsfqHW2sx/rMmB
 i/kSfYnFVCVjkJFfS9kG6kJ8ZpRVDp3SqwWyVj40F5nrD3BOaBX3ZGudf53G2Gm14jIC
 aPtUqBjcNarnk6qLAbG95veaHvVfHlgQPCauKA1//Cc5Qg6XfqfaV00s9OT8w7Rg27jQ
 Sdeg==
X-Gm-Message-State: AOAM533MGozSIEiwtErWhLu2JqVdWeG3jazj5RsGjCSyJTT6R3oF2fLi
 EusDzZfHywPQeJBIIcDg1zM=
X-Google-Smtp-Source: ABdhPJxa/ztBS3OI9UzQlD2bNOaq3u/zZ+U+FabKOTUQpQwEJtJWgK1EaNSAxZ0ej9WsfQ6Hw3Wkzw==
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr8335256wmb.3.1591188050979;
 Wed, 03 Jun 2020 05:40:50 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id x66sm2857811wmb.40.2020.06.03.05.40.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 05:40:50 -0700 (PDT)
Subject: Re: [PATCH v1 9/9] .travis.yml: allow failure for unreliable hosts
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-10-alex.bennee@linaro.org>
 <7783d10d-faa9-b454-a0cd-dba51be1a9af@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <d3dda4be-a358-1444-a068-b10243683ef5@amsat.org>
Date: Wed, 3 Jun 2020 14:40:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7783d10d-faa9-b454-a0cd-dba51be1a9af@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Fam Zheng <fam@euphon.net>, robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 10:18 AM, Philippe Mathieu-Daudé wrote:
> On 6/2/20 5:46 PM, Alex Bennée wrote:
>> They will still run but they won't get in the way of the result.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  .travis.yml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 564be50a3c1..ec6367af1f0 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -429,6 +429,7 @@ jobs:
>>        env:
>>          - TEST_CMD="make check check-tcg V=1"
>>          - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS}"
>> +        - UNRELIABLE=true
>>  
>>      - name: "[ppc64] GCC check-tcg"
>>        arch: ppc64le
>> @@ -493,6 +494,7 @@ jobs:
>>        env:
>>          - TEST_CMD="make check check-tcg V=1"
>>          - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
>> +        - UNRELIABLE=true
>>        script:
>>          - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>>          - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
>> @@ -535,6 +537,7 @@ jobs:
>>          - TEST_CMD="make check-unit"
>>          - CONFIG="--disable-containers --disable-tcg --enable-kvm
>>                    --disable-tools --host-cc=clang --cxx=clang++"
>> +        - UNRELIABLE=true
>>  
>>      # Release builds
>>      # The make-release script expect a QEMU version, so our tag must start with a 'v'.
>> @@ -556,3 +559,5 @@ jobs:
>>          - mkdir -p release-build && cd release-build
>>          - ../configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
>>          - make install
>> +  allow_failures:
>> +    - env: UNRELIABLE=true
>>
> 
> It is frustrating when you are expecting Travis to fail to see test this
> patch, but Travis is back working correctly...
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Apparently Travis fixed their problem:

$ df -h
Filesystem
                             Size  Used Avail Use% Mounted on
/var/snap/lxd/common/lxd/storage-pools/instances/containers/travis-job-philmd-qemu-694161395/rootfs
  19G  2.8G   16G  15% /

I couldn't test if allow_failures works as expected, anyway:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

