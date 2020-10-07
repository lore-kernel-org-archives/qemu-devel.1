Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BB2C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2729E20789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjIhPfQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2729E20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ8Pq-0007HE-50
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 08:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ89U-00005A-TL
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:02:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:34489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ89S-0002Lv-P0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:02:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id l15so4353920wmh.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 05:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OGDE0lsRIvuMNkBSAUAm/UBcR8qx3fuaHP/xDWWmOpI=;
 b=XjIhPfQik6q3CTBO1TwNJpwQ5sKYZXhQzVRaIRX29lXNKx7u2cvYbB00Z/FdKxM+1e
 r2WOfPi0afunIsON4JklMZjxUYn4JcN3o+xe3C7pd01qnSivD5M9I15J7Ih79ot2O+JB
 q1D/32/ijsRctXUN6zbgRFJMul0PnNJ6qJvoLhriHVSNkvCqfQ+29MISstNcGuElzMRA
 nKS29wrq3tNIhTjXdLX/vXl/wkWVF1hQ12h7imsJFMbpFWyvki7+oRRdF46f+7SWGSeg
 EGzMemL0xijZynct/BrFIBWqTDY03aTjGm/6yJOZxsm+pvvJqYYSA2a0riYsG89FspKR
 ZPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OGDE0lsRIvuMNkBSAUAm/UBcR8qx3fuaHP/xDWWmOpI=;
 b=ctmPOPnPwyLigWvySbNEfyczGdll9juvvKltUdZmb+TmETkUkNt+IoTGtMy2LYJMzi
 PxH4HIXqFRMsdlPGlLssNmuBcvkuQd5g3PSGwszh0SuSjuB1Eno1q7RzByAbhjJiPdSu
 8qQchQ9TkkscaFR3xVa8+stDs3twvhO9+eFfvayHEyeLQaQahr2yZufiNmZGrgB/EpAv
 S1zUvxLBR0aElDCC0J+S07hkf3/RZ3qPMEOLIFbf9w18YV6ka1Vjgb3p7OtiJSM9zGeg
 wOrEuTd+9ygnO7e7rt4DimL3V/Z9or4UHZc7AYiqAsEUNOmdFVsgZTZTURCfrYY47I4v
 7Z1Q==
X-Gm-Message-State: AOAM531zjAbBPVkyJz01mNih9iDH334Pe215BNshWJD+p6R2uzesMPa9
 wgGPiRei9ChLUK1KHLXrMghiZg==
X-Google-Smtp-Source: ABdhPJxu87hRFZAD4loBZ4Iy7orvrARSqit8nre3KbFsIPez6Kc8VivuJjTE2YAXpXBxuokZXgUJzA==
X-Received: by 2002:a1c:3283:: with SMTP id y125mr3000396wmy.61.1602072152961; 
 Wed, 07 Oct 2020 05:02:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y6sm2664036wrt.80.2020.10.07.05.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 05:02:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E572E1FF7E;
 Wed,  7 Oct 2020 13:02:30 +0100 (BST)
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
 <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
 <875z7p3t9e.fsf@linaro.org>
 <e43be86d-1847-199f-4cbd-2e3bd124d70a@gmail.com>
 <CADBGO794+ZPD=B=dFuA7SC96g3GDJXF1A8j=VP6MeiSw1Sf4oQ@mail.gmail.com>
 <d8d79b4c-aeb4-4f07-7110-91d8d1afd701@gmail.com>
 <87362r3cbt.fsf@linaro.org>
 <61c49583-c548-a8b2-7106-59011196f430@gmail.com>
 <CADBGO7-BaTH3MBZa6Dbv2+uxKNbv3ztwQ=iu_FCgrcrKBUzCPw@mail.gmail.com>
 <4da67d13-a774-f62e-ad89-de062cbe81da@gmail.com>
 <87blhe1esd.fsf@linaro.org>
 <f32593d0-e87b-0549-7b59-f58da24c9130@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Schneider <74cmonty@gmail.com>
Subject: Re: Emulate Rpi with QEMU fails
In-reply-to: <f32593d0-e87b-0549-7b59-f58da24c9130@gmail.com>
Date: Wed, 07 Oct 2020 13:02:30 +0100
Message-ID: <87362q1bxl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Schneider <74cmonty@gmail.com> writes:

> Are you referring to this tool?
> https://github.com/stefano-garzarella/qemu-boot-time=20
> <https://github.com/stefano-garzarella/qemu-boot-time>

No - just plain perf:

  perf record $QEMU $ARGS

Then a "perf report" which will show you the hotspots, for example:

   8.92%  qemu-system-aar  qemu-system-aarch64      [.] helper_lookup_tb_ptr
   4.76%  qemu-system-aar  qemu-system-aarch64      [.] liveness_pass_1
   3.69%  qemu-system-aar  qemu-system-aarch64      [.] tcg_gen_code
   2.95%  qemu-system-aar  qemu-system-aarch64      [.] qht_lookup_custom
   2.93%  qemu-system-aar  qemu-system-aarch64      [.] tcg_optimize
   1.28%  qemu-system-aar  qemu-system-aarch64      [.] tcg_out_opc.isra.15
   1.09%  qemu-system-aar  qemu-system-aarch64      [.] get_phys_addr_lpae
   1.09%  qemu-system-aar  [kernel.kallsyms]        [k] isolate_freepages_b=
lock
   1.05%  qemu-system-aar  qemu-system-aarch64      [.] cpu_get_tb_cpu_state
   0.98%  qemu-system-aar  [kernel.kallsyms]        [k] do_syscall_64
   0.94%  qemu-system-aar  qemu-system-aarch64      [.] tb_lookup_cmp
   0.78%  qemu-system-aar  qemu-system-aarch64      [.] init_ts_info
   0.73%  qemu-system-aar  qemu-system-aarch64      [.] tb_htable_lookup
   0.73%  qemu-system-aar  qemu-system-aarch64      [.] tb_gen_code
   0.73%  qemu-system-aar  qemu-system-aarch64      [.] tlb_set_page_with_a=
ttrs

>
>
> Am 07.10.2020 um 13:00 schrieb Alex Benn=C3=A9e:
>> perf to record your boot


--=20
Alex Benn=C3=A9e

