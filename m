Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332F0C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4A6207E8
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yb0Qp0vE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4A6207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR9yo-0007QX-Qi
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kR9nV-0007z2-4h
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 04:00:09 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kR9nS-00070D-IB
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 04:00:08 -0400
Received: by mail-pg1-x542.google.com with SMTP id u24so9221825pgi.1
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wVNW4m/sWQPhrdPNlsV6HiXfvIJ1rNz3KP/MLB8lgoM=;
 b=Yb0Qp0vEkcdqO0g1Ys+XPoXj4k/upQ8XPw/iNmFDcBHoHjD9NaCpXcFyD5HA88+tqg
 +tuqgZ8sn6ygXGhscoXSg868zpnKRHonao/KEkAjQQLjvEpDjb1Y87+2JXCFZGiasRm/
 S6COLbxI+C53K3IdZ9M0+n0sRRF0WPw7bH+6wQAasCBnhK6chvQZHyhpm+1pctAtD829
 4UtRxdJT6oHuA3AQIIYFOSfrAThDjuaB30/MVrGWU8i1f7g6+45PMvPUTIjjzBnqlC7S
 Xq7lZR4PdrDm4vDuk4GUODW6foNuUiUD9Owly3+TyAlt+kMb4gUsRojvcin4MPMVclD+
 PmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wVNW4m/sWQPhrdPNlsV6HiXfvIJ1rNz3KP/MLB8lgoM=;
 b=iq44lssuPnwa7w7gSsyA0wgcUR84Yukvy8cubzAXE9OPhQOrZFqWN4PgLOZ9yHgctC
 dqssHWW3jL1+Qu/R62nVOUg6IZNGkFxcqG23dyNB/AEAZQNvG/s0mxYCXCSnZbA+CbnS
 K6bQx5pgkD0h6sjPC48gXVN+cbIODxpU9OWSESS8SB2IefpDwnJDyg/Xo8H0eadIPsl+
 lFV2adJGadeH8W8Id/lJdlpE/Rb8acqBwTOyXw538IpywXc0VfK3nfOGOvNbDiVxOX5O
 QXq7gOyVK7C09ZHLQPCJ680JqvFvE+VjmR8nb/tQM/61lghJGcQZzw2sQYWUv7Xbd71F
 CHcg==
X-Gm-Message-State: AOAM533Em6yR/HbeXWApWpPLjoKXfsfo1k3FSK+2K9kyniojbXuqNnYv
 Or3eazSy1EdXwx5+TCe4OA4=
X-Google-Smtp-Source: ABdhPJxC0FDIbNd14uJZiyphnSCwm6unJXbkv4UYUPPBhVi85APe7jElvjQIkpiVrBqJadIkzSWUcA==
X-Received: by 2002:a62:5ac3:0:b029:153:f1d4:37ee with SMTP id
 o186-20020a625ac30000b0290153f1d437eemr15182638pfb.38.1602316803991; 
 Sat, 10 Oct 2020 01:00:03 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id k128sm14830803pfd.99.2020.10.10.01.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 01:00:03 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Sat, 10 Oct 2020 15:59:55 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v10 6/7] test: new qTest case to test the
 vhost-user-blk-server
Message-ID: <20201010075955.46fqgg4vodubvvlz@Rk>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
 <20200918080912.321299-7-coiby.xu@gmail.com>
 <20200923123606.GC51019@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200923123606.GC51019@stefanha-x1.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=coiby.xu@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: kwolf@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, bharatlkmlkvm@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 01:36:06PM +0100, Stefan Hajnoczi wrote:
>On Fri, Sep 18, 2020 at 04:09:11PM +0800, Coiby Xu wrote:
>> +int qtest_socket_client(char *server_socket_path)
>> +{
>> +    struct sockaddr_un serv_addr;
>> +    int sock;
>> +    int ret;
>> +    int retries = 0;
>> +    sock = socket(PF_UNIX, SOCK_STREAM, 0);
>> +    g_assert_cmpint(sock, !=, -1);
>> +    serv_addr.sun_family = AF_UNIX;
>> +    snprintf(serv_addr.sun_path, sizeof(serv_addr.sun_path), "%s",
>> +             server_socket_path);
>> +
>> +    for (retries = 0; retries < 3; retries++) {
>> +        ret = connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr));
>> +        if (ret == 0) {
>> +            break;
>> +        }
>> +        g_usleep(G_USEC_PER_SEC);
>> +    }
>
>This is a race condition. On a heavily loaded machine the server might
>not be available within 3 seconds and the test will fail randomly.
>
>Solutions:
>1. Wait output from the server indicating it is ready (e.g. 'Listening
>   on /path/to/foo.sock...') when spawning the server process.
>2. Create the listen socket and pass the fd to the server process. This
>   way the socket already exists can the client will block in connect
>   until the server accepts the connection.
>3. Create a socketpair. Pass one side to the server and use the other
>   side in the client.
>
>However, I think this is okay for now. After my patch series that
>converts the vhost-user-blk server to the new block exports API we can
>consider how to pass file descriptors.
>
>> +static void quit_storage_daemon(void *qmp_test_state)
>> +{
>> +    const char quit_str[] = "{ 'execute': 'quit' }";
>> +
>> +    /* Before quiting storate-daemon, quit qemu to avoid dubious messages */
>> +    qobject_unref(qtest_qmp(global_qtest, quit_str));
>> +
>> +    /*
>> +     * Give storage-daemon enough time to wake up&terminate
>> +     * vu_client_trip coroutine so the Coroutine object could
>> +     * be cleaned up. Otherwise LeakSanitizer would complain
>> +     * about memory leaks.
>> +     */
>> +    g_usleep(1000);
>
>Also a race that may cause random failures. This can be addressed after
>the block exports API conversion.

Thank you for spotting two race conditions!

--
Best regards,
Coiby

