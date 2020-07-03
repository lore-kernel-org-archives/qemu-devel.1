Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416BFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F421D2073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="URB+5XeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F421D2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQmL-0004r0-99
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrQlB-0002x3-JM
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:50:05 -0400
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:48016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrQl8-0007eb-NN
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1593802202; bh=zAJ680phwsV6uLTNJA6mMTwSNJTopDTWNV8F
 VfPVAGw=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:
 X-Originating-IP; b=URB+5XeA0kc692RB4jT3fmO5j2iG9iyk6En4uRCZome4OH
 JiJVT/qAnooEjve5ZyA2r6CUXCAzwMbvTkyDSQMJSzs/sHHYOvcjm50di5iWyUOk/QZ
 XhAuaA0Yaruq8VAKjd49+gdmdsGhmD/a6xIMWWRC2+emD+vIFVZ51refN4kWrAAPBBT
 HhRa8UJE3va79/3gXnB6YbnrjHlSieFI8LAdh1aW5Ro98gAsxiW0AeyF8UtXs38hEGl
 No7c20qtfeWcsTf4mw2saim9d6LKtABEIqnXpYZDGrpWjsFGvCniowQw19Y6R2MDCCW
 KPwcNmzTW8fDHo7bpWXsokrEl5Ww==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=IGCCu2Cplx0Cmlu+tssi5fWZEeiVMnmJ08SRVuafxL8hozKWLoacouWNYTCRqXyUJpRBoq3e3M6CzMqkm7rt+IJtz4NkfVVv3v063g+kjEORaaSm8ONaQ7cjC8qJESl37kZJlUeYJWf0MWP+2/ezYawSNMw7CZOQw3fqfZV5qXZzVvWEmJ7cL+gE8zM3/2gEXL3W0hY55C0CzPelFm35bLInEKyUABDVs42+4icl7cFeJ9nOR1dp1iu4uWN6Ec8AW12MQN+9eTqgWK5ESi7fg8t8p3RSCFpAQTNDOJLmUJgxwT4eQX+E6vnNODoDRsXFBlJYm7h4KcvZvaaFMs9PPw==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>)
 id 1jrQl5-000BU8-TO; Fri, 03 Jul 2020 14:49:59 -0400
Message-ID: <5EFF7DD7.1000605@mindspring.com>
Date: Fri, 03 Jul 2020 14:49:59 -0400
From: Michele Denber <denber@mindspring.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: Peter Maydell <peter.maydell@linaro.org>
Subject: gmake in Solaris 11.4: _IOR missing
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
 <5EFF5DFC.2060006@mindspring.com>
 <CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com>
In-Reply-To: <CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------070502080900050109000608"
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca53ca55b06232185c30f5cadbdfa9112ba350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.65; envelope-from=denber@mindspring.com;
 helo=elasmtp-kukur.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 14:50:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Peter Tribble <peter.tribble@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------070502080900050109000608
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/03/20 12:50, Peter Maydell wrote:
> ...
> This is because you're trying to apply the patch to the
> 5.0.0 release, but it was made against the current head-of-git,
> and this file has changed a little between the two.
> Generally we do all development against head-of-git, so
> I would suggest that you try again with that.
>
> As it happens, the current preferred fix for the drm.c issue
> is this one:
> https://patchew.org/QEMU/20200703145614.16684-1-peter.maydell@linaro.org/20200703145614.16684-10-peter.maydell@linaro.org/
I see.  I downloaded 5.0.0 mainly because I don't understand how git 
works.  Anyway, I applied your new  patch and it worked.

I tried gmake again and got further.  This time it's stopping here:

root@hemlock:~/qemu-5.0.0# gmake -j16
...
CC      hw/usb/hcd-uhci.o
In file included from hw/tpm/tpm_emulator.c:37:0:
hw/tpm/tpm_ioctl.h:222:30: warning: implicit declaration of function 
'_IOR\'; did you mean '_IORW'? [-Wimplicit-function-declaration]
      PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
                               ^~~~
                               _IORW
hw/tpm/tpm_ioctl.h:222:43: error: expected expression before 
\u2018ptm_cap\u2019
      PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
                                            ^~~~~~~
hw/tpm/tpm_ioctl.h:223:30: warning: implicit declaration of function 
\u2018_IOWR\u2019; did you mean \u2018_IOWRT\u2019? 
[-Wimplicit-function-declaration]
      PTM_INIT               = _IOWR('P', 1, ptm_init),
                               ^~~~~
                               _IOWRT
hw/tpm/tpm_ioctl.h:223:44: error: expected expression before 
\u2018ptm_init\u2019
      PTM_INIT               = _IOWR('P', 1, ptm_init),
                                             ^~~~~~~~
hw/tpm/tpm_ioctl.h:224:43: error: expected expression before 
\u2018ptm_res\u2019
      PTM_SHUTDOWN           = _IOR('P', 2, ptm_res),
                                            ^~~~~~~
hw/tpm/tpm_ioctl.h:225:43: error: expected expression before 
\u2018ptm_est\u2019
      PTM_GET_TPMESTABLISHED = _IOR('P', 3, ptm_est),
                                            ^~~~~~~
hw/tpm/tpm_ioctl.h:226:44: error: expected expression before 
\u2018ptm_loc\u2019
      PTM_SET_LOCALITY       = _IOWR('P', 4, ptm_loc),
                                             ^~~~~~~
hw/tpm/tpm_ioctl.h:227:43: error: expected expression before 
\u2018ptm_res\u2019
      PTM_HASH_START         = _IOR('P', 5, ptm_res),
                                            ^~~~~~~
hw/tpm/tpm_ioctl.h:228:44: error: expected expression before 
\u2018ptm_hdata\u2019
      PTM_HASH_DATA          = _IOWR('P', 6, ptm_hdata),
                                             ^~~~~~~~~
hw/tpm/tpm_ioctl.h:229:43: error: expected expression before 
\u2018ptm_res\u2019
      PTM_HASH_END           = _IOR('P', 7, ptm_res),
                                            ^~~~~~~
hw/tpm/tpm_ioctl.h:230:43: error: expected expression before 
\u2018ptm_res\u2019
      PTM_CANCEL_TPM_CMD     = _IOR('P', 8, ptm_res),
                                            ^~~~~~~
hw/tpm/tpm_ioctl.h:231:43: error: expected expression before 
\u2018ptm_res\u2019
      PTM_STORE_VOLATILE     = _IOR('P', 9, ptm_res),
                                            ^~~~~~~
hw/tpm/tpm_ioctl.h:232:47: error: expected expression before 
\u2018ptm_reset_est\u2019
      PTM_RESET_TPMESTABLISHED = _IOWR('P', 10, ptm_reset_est),
                                                ^~~~~~~~~~~~~
hw/tpm/tpm_ioctl.h:233:45: error: expected expression before 
\u2018ptm_getstate\u2019
      PTM_GET_STATEBLOB      = _IOWR('P', 11, ptm_getstate),
                                              ^~~~~~~~~~~~
hw/tpm/tpm_ioctl.h:234:45: error: expected expression before 
\u2018ptm_setstate\u2019
      PTM_SET_STATEBLOB      = _IOWR('P', 12, ptm_setstate),
                                              ^~~~~~~~~~~~
   CC      hw/usb/hcd-ohci.o
hw/tpm/tpm_ioctl.h:235:44: error: expected expression before 
\u2018ptm_res\u2019
      PTM_STOP               = _IOR('P', 13, ptm_res),
                                             ^~~~~~~
hw/tpm/tpm_ioctl.h:236:44: error: expected expression before 
\u2018ptm_getconfig\u2019
      PTM_GET_CONFIG         = _IOR('P', 14, ptm_getconfig),
                                             ^~~~~~~~~~~~~
hw/tpm/tpm_ioctl.h:237:44: error: expected expression before 
\u2018ptm_res\u2019
      PTM_SET_DATAFD         = _IOR('P', 15, ptm_res),
                                             ^~~~~~~
hw/tpm/tpm_ioctl.h:238:45: error: expected expression before 
\u2018ptm_setbuffersize\u2019
      PTM_SET_BUFFERSIZE     = _IOWR('P', 16, ptm_setbuffersize),
                                              ^~~~~~~~~~~~~~~~~
   CC      hw/usb/hcd-ohci-pci.o
gmake: *** [/export/home/denber/qemu-5.0.0/rules.mak:69: 
hw/tpm/tpm_emulator.o] Error 1

It appears that _IOR & friends are defined in /usr/include/sys/ioccom.h, 
but I can't figure out how to point gmake to that.  Do I need some sort 
of "-I" in the Makefile?


When I built QEMU 2.12, I ran into this too and ended up just commenting 
out all the references to _IOR, etc. in hw/tpm/tpm_ioctl.h but maybe we 
can do something more elegant this time.  Thanks.

             - Michele

--------------070502080900050109000608
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 07/03/20 12:50, Peter Maydell wrote:
    <blockquote
cite="mid:CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com"
      type="cite">...
      <pre wrap="">
This is because you're trying to apply the patch to the
5.0.0 release, but it was made against the current head-of-git,
and this file has changed a little between the two.
Generally we do all development against head-of-git, so
I would suggest that you try again with that.

As it happens, the current preferred fix for the drm.c issue
is this one:
<a class="moz-txt-link-freetext" href="https://patchew.org/QEMU/20200703145614.16684-1-peter.maydell@linaro.org/20200703145614.16684-10-peter.maydell@linaro.org/">https://patchew.org/QEMU/20200703145614.16684-1-peter.maydell@linaro.org/20200703145614.16684-10-peter.maydell@linaro.org/</a></pre>
    </blockquote>
    I see.  I downloaded 5.0.0 mainly because I don't understand how git
    works.  Anyway, I applied your new  patch and it worked.<br>
    <br>
    I tried gmake again and got further.  This time it's stopping here:<br>
    <br>
    <small><font face="Courier New, Courier, monospace"><a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a>
        gmake -j16<br>
        ...<br>
        CC      hw/usb/hcd-uhci.o<br>
        In file included from hw/tpm/tpm_emulator.c:37:0:<br>
        hw/tpm/tpm_ioctl.h:222:30: warning: implicit declaration of
        function '_IOR\'; did you mean '_IORW'?
        [-Wimplicit-function-declaration]<br>
             PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),<br>
                                      ^~~~<br>
                                      _IORW<br>
        hw/tpm/tpm_ioctl.h:222:43: error: expected expression before
        \u2018ptm_cap\u2019<br>
             PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),<br>
                                                   ^~~~~~~<br>
        hw/tpm/tpm_ioctl.h:223:30: warning: implicit declaration of
        function \u2018_IOWR\u2019; did you mean \u2018_IOWRT\u2019?
        [-Wimplicit-function-declaration]<br>
             PTM_INIT               = _IOWR('P', 1, ptm_init),<br>
                                      ^~~~~<br>
                                      _IOWRT<br>
        hw/tpm/tpm_ioctl.h:223:44: error: expected expression before
        \u2018ptm_init\u2019<br>
             PTM_INIT               = _IOWR('P', 1, ptm_init),<br>
                                                    ^~~~~~~~<br>
        hw/tpm/tpm_ioctl.h:224:43: error: expected expression before
        \u2018ptm_res\u2019<br>
             PTM_SHUTDOWN           = _IOR('P', 2, ptm_res),<br>
                                                   ^~~~~~~<br>
        hw/tpm/tpm_ioctl.h:225:43: error: expected expression before
        \u2018ptm_est\u2019<br>
             PTM_GET_TPMESTABLISHED = _IOR('P', 3, ptm_est),<br>
                                                   ^~~~~~~<br>
        hw/tpm/tpm_ioctl.h:226:44: error: expected expression before
        \u2018ptm_loc\u2019<br>
             PTM_SET_LOCALITY       = _IOWR('P', 4, ptm_loc),<br>
                                                    ^~~~~~~<br>
        hw/tpm/tpm_ioctl.h:227:43: error: expected expression before
        \u2018ptm_res\u2019<br>
             PTM_HASH_START         = _IOR('P', 5, ptm_res),<br>
                                                   ^~~~~~~<br>
        hw/tpm/tpm_ioctl.h:228:44: error: expected expression before
        \u2018ptm_hdata\u2019<br>
             PTM_HASH_DATA          = _IOWR('P', 6, ptm_hdata),<br>
                                                    ^~~~~~~~~<br>
        hw/tpm/tpm_ioctl.h:229:43: error: expected expression before
        \u2018ptm_res\u2019<br>
             PTM_HASH_END           = _IOR('P', 7, ptm_res),<br>
                                                   ^~~~~~~<br>
        hw/tpm/tpm_ioctl.h:230:43: error: expected expression before
        \u2018ptm_res\u2019<br>
             PTM_CANCEL_TPM_CMD     = _IOR('P', 8, ptm_res),<br>
                                                   ^~~~~~~<br>
        hw/tpm/tpm_ioctl.h:231:43: error: expected expression before
        \u2018ptm_res\u2019<br>
             PTM_STORE_VOLATILE     = _IOR('P', 9, ptm_res),<br>
                                                   ^~~~~~~<br>
        hw/tpm/tpm_ioctl.h:232:47: error: expected expression before
        \u2018ptm_reset_est\u2019<br>
             PTM_RESET_TPMESTABLISHED = _IOWR('P', 10, ptm_reset_est),<br>
                                                       ^~~~~~~~~~~~~<br>
        hw/tpm/tpm_ioctl.h:233:45: error: expected expression before
        \u2018ptm_getstate\u2019<br>
             PTM_GET_STATEBLOB      = _IOWR('P', 11, ptm_getstate),<br>
                                                     ^~~~~~~~~~~~<br>
        hw/tpm/tpm_ioctl.h:234:45: error: expected expression before
        \u2018ptm_setstate\u2019<br>
             PTM_SET_STATEBLOB      = _IOWR('P', 12, ptm_setstate),<br>
                                                     ^~~~~~~~~~~~<br>
          CC      hw/usb/hcd-ohci.o<br>
        hw/tpm/tpm_ioctl.h:235:44: error: expected expression before
        \u2018ptm_res\u2019<br>
             PTM_STOP               = _IOR('P', 13, ptm_res),<br>
                                                    ^~~~~~~<br>
        hw/tpm/tpm_ioctl.h:236:44: error: expected expression before
        \u2018ptm_getconfig\u2019<br>
             PTM_GET_CONFIG         = _IOR('P', 14, ptm_getconfig),<br>
                                                    ^~~~~~~~~~~~~<br>
        hw/tpm/tpm_ioctl.h:237:44: error: expected expression before
        \u2018ptm_res\u2019<br>
             PTM_SET_DATAFD         = _IOR('P', 15, ptm_res),<br>
                                                    ^~~~~~~<br>
        hw/tpm/tpm_ioctl.h:238:45: error: expected expression before
        \u2018ptm_setbuffersize\u2019<br>
             PTM_SET_BUFFERSIZE     = _IOWR('P', 16, ptm_setbuffersize),<br>
                                                     ^~~~~~~~~~~~~~~~~<br>
          CC      hw/usb/hcd-ohci-pci.o<br>
        gmake: *** [/export/home/denber/qemu-5.0.0/rules.mak:69:
        hw/tpm/tpm_emulator.o] Error 1</font></small><br>
    <br>
    It appears that _IOR &amp; friends are defined in
    /usr/include/sys/ioccom.h, but I can't figure out how to point gmake
    to that.  Do I need some sort of "-I" in the Makefile?<br>
    <font face="Courier New, Courier, monospace"></font><br>
    <br>
    When I built QEMU 2.12, I ran into this too and ended up just
    commenting out all the references to _IOR, etc. in
    hw/tpm/tpm_ioctl.h but maybe we can do something more elegant this
    time.  Thanks.<br>
    <br>
                - Michele
  </body>
</html>

--------------070502080900050109000608--

