Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_IMAGE_ONLY_24,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E643AC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 07:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6F520716
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 07:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pFiC5Aen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6F520716
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI65j-0000DW-NT
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 03:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <viktor.madarasz@yahoo.com>) id 1jI64v-0007mj-QJ
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 03:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <viktor.madarasz@yahoo.com>) id 1jI64u-00056E-GJ
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 03:40:25 -0400
Received: from sonic315-22.consmr.mail.ne1.yahoo.com ([66.163.190.148]:42122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <viktor.madarasz@yahoo.com>)
 id 1jI64u-00055n-BV
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 03:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1585381222; bh=zNJLYN50+tFJxcXSJTKv3JDRiKSI7QBLjKG2+V5D0TM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject;
 b=pFiC5Aen5Czi3VJYH9M8JVLmxZmSySEbhjLgna+mPV0FU2G/P52e5lN3jKwVPXKGHClsgMByQD021KczqgDe7Re/NLbPG6MCGpWWl54WYFZYC31UqKMRbMmuLJVQGbzANxpgFHdnTFeXKeTQlHc6aMjuxsy/8waeAU6z+VTL1yGxH4+oPhvnZ74zapZDy38RBNMMeOaXuFmzMepO5x+C3EoTEBN1jXpKAM4pNgB18d7BzbGdKaKAMXRQSdLmEc1E9RjZpe51E6G8T8ANwCLs9KNVXkYori36yLtNiG1+LsHN6SwCYV2b6eY9cImGR2/h3bgD49XHOAKQ4WFLMZ/aTA==
X-YMail-OSG: FJPFRQkVM1lVNYrTPjxnzSkRaPBDZjdFrS8Z_A3lCmMrPd9akge_SwvKgCSgoJY
 C_LdkXx58CKOGiieFSFtxFnNLLVkFVk32MQruWPZE2pqrb7Mvs5cP4XvEfhEkvA.elCQ17.tPBPH
 kdC9iga4WWInqntd33mHarnhpxjvjL9Afer_.jZGUFf0QovXEQA1aNEjrtCeeA1.J2Y76A_VRUAr
 ucJnOCWFDsZkphCUPxvXrZ4dEjfQl_oxkVZqAK21tQPLsp9z.UpE6wn7aAqAbbme.LQcmV_R1Ggs
 xT48ujyWTdYVMTXxn4jfOEODnix_Y2O0JvOtQTOJ4A1Y1e5tgZXb_.TRVxs_WOZvWOMwtJ_Q42mC
 q.xMuPZccRhyvo2U51D9xDmyVpX.Y9tQsq0Uo9TJfDo9rr2LkXtkSuNYNRYHmLHV7Y4krhG3EqDc
 wXTx1xiQjThhAQ6rphW3fm3M78qNS6X6zzpRvldsPXOkBiFrkkwjmZioaGTRqgISqaXf9koK7KGQ
 oOKp9mYRCpxZkfONLiKiOfsaB3ogJ8NZdHzx_1pEvPIGt3fOVTBQOcGoF_URxKK0AGli7nub9s34
 Q9Wm8ZMRgbuXnLv6vYNZbMWqaMny1LYh7Ix.3u74hq55PmoVL9dVbDimnMdTWzDs8fb1UW9LB16P
 tH_PkKC99YABGPURZ.kd3fmIk8rlAlE.FR.EbU1PPNknuZxDcv1OG0E_zG4xO0u.x6TSryVS05qQ
 _oSP0KpnNq9wWYJUtPdHTbC8WRnKQeKN1seX3.jq5tOJ7K0FP0B8zG_1Vt9dxosJVzT7Wh33DxVB
 I9AN2RputUb_HQlWlIFhdhPik2I9IiMJtoCjq9.AXcInWnGibKTFI1kUrxL0uG_ReQQnPIcJq_NS
 ZBMdBnxk35bF79DWPv2gj5avwf6mKzP6YhUDl0tvP_82gmlmo.5uot9OEMmnSSwbppQftmLanmyl
 3rQZ2qAquf1stw6D5NDRwZ0eB9FyletDb2BW2maI.RYDwUX.mjnfvt.cKTiXuMyvBynmF35VtWo3
 KEJMyXLNpuQFWcce7l3T4zH_QmwmMaNlmXD9BH3FJs0XHN610fOdoBJOerL8Sdrm6o7Igzmi_Pm_
 P0Ffw0MhGkzt8LyycVuEJuPGunLXe10.3UlnOyftSnuWlZ_5x9GqlW4eaA6TSR8r4lN2EJigEFdr
 vf3419dUNR.yMtSRE0zFV8343E02n3aeW17qJuBtmbRPQZkSG9RUos1_IwjmAOgS92xaUXa.CV7v
 V7aBahUWGqBlyQBuDdQMbX4v7pAZ2ni.zrMmFxQhYLkh6zdxmDi3CWHXdpk4uIWTDiWG13PydwF5
 byhhLXI.qg4_sHpdxlfvNUa18nN5LiuwUZWzvB_KuPO0aXIRM32rQ2vbNV75PD29HybAHtjTJ.bV
 XYbnah9FH4OXhPUBt9ElQGfKKTKC2Zkbmdk8efR8G_wlVIh1bpJwakLyp4cdVgp4ncustdgFW9Lp
 F1iWalLjRcm4LRjdvwho5i38ajMevFFnVgF.trtXYtJuBCabvRqs_f8liuU6DAhvx38Z4XJ1epLX
 g5I.SCx5Md6qsYwy43.81G7dnpm3FiD.5_w46lILS.Jpp3gT.qVUuDrR6seOqTaAnyn0r75RHudo
 UKRYJyutx.8QxAIqPIGNFgWm0UyAXJQEoVOK7gRZoXhs_XDCxZkJj_z4T8vMbpYYS
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sat, 28 Mar 2020 07:40:22 +0000
Received: by smtp415.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID c2b400ab7b6cb91af35b20c70188edb6; 
 Sat, 28 Mar 2020 07:40:20 +0000 (UTC)
Subject: Re: Error building Qemu 2.12.0 on Fedora 31 GCC 9.2.1 with the below
 error
To: Peter Maydell <peter.maydell@linaro.org>,
 Viktor Madarasz <viktor.madarasz@yahoo.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <6dbdab0f-93ff-1df0-bff8-dd720d990be3.ref@yahoo.com>
 <6dbdab0f-93ff-1df0-bff8-dd720d990be3@yahoo.com>
 <CAFEAcA8aMhEYr2o3Pk7KrPd_t82nYS4PQw8+sPBkeNxT1LRC_A@mail.gmail.com>
From: Viktor Madarasz <viktor.madarasz@yahoo.com>
Message-ID: <07f1e22c-6871-38bd-71fd-bcaf10e5717e@yahoo.com>
Date: Sat, 28 Mar 2020 08:40:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8aMhEYr2o3Pk7KrPd_t82nYS4PQw8+sPBkeNxT1LRC_A@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------0CD831FCCE569CE3D4ECD43D"
Content-Language: en-US
X-Mailer: WebService/1.1.15555 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_242)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 66.163.190.148
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------0CD831FCCE569CE3D4ECD43D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/20 10:28 PM, Peter Maydell wrote:


Hi Peter

Thanks, actually passing the argument to ./configure 
--target-list=ppc64-softmmu  resulted in a successfull build and it now 
works Ok.


Viktor

> On Fri, 27 Mar 2020 at 20:49, Viktor Madarasz <viktor.madarasz@yahoo.com> wrote:
>> Hi
>>
>> Im trying to build Qemu 2.12.0 on Fedora 31 with GCC 9.2.1 as this
>> particular qemu version is the only one working for my
>> qemu-systems-ppc64 emulation I need
>>
>> ./configure runs with no problem but running make breaks at this point.
>>
> If you try to build an old QEMU on a new distro like this
> you're likely to run a bunch of minor build bugs that have
> been fixed in mainline. You will probably need to trawl through
> the git history or the mailing list archives to find the
> relevant commits which fix them (searching for error messages
> is often a good tactic).
>
> You should also choose configure options to minimise the
> amount of source you build that you don't need. If you
> only need qemu-system-ppc64, then pass configure the
> "--target-list=ppc64-softmmu" argument and it will build
> only that and won't try to build the linux-user code at all.
> If configure of that vintage supports --disable-tools that
> is also going to be useful (and if some bit of source that
> looks uninteresting fails check to see if there's a relevant
> --disable-something to just stop building it.)
>
> thanks
> -- PMM



--------------0CD831FCCE569CE3D4ECD43D
Content-Type: multipart/related;
 boundary="------------AF7AE11C095C9B3703FBB14D"


--------------AF7AE11C095C9B3703FBB14D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 3/27/20 10:28 PM, Peter Maydell
      wrote:<br>
    </div>
    <p><br>
    </p>
    <p>Hi Peter</p>
    <p>Thanks, actually passing the argument to ./configure
      --target-list=ppc64-softmmu  resulted in a successfull build and
      it now works Ok.</p>
    <p><img src="cid:part1.535F5C69.D58C9F58@yahoo.com" alt=""></p>
    <p><br>
    </p>
    <p>Viktor<br>
    </p>
    <blockquote type="cite"
cite="mid:CAFEAcA8aMhEYr2o3Pk7KrPd_t82nYS4PQw8+sPBkeNxT1LRC_A@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Fri, 27 Mar 2020 at 20:49, Viktor Madarasz <a class="moz-txt-link-rfc2396E" href="mailto:viktor.madarasz@yahoo.com">&lt;viktor.madarasz@yahoo.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Hi

Im trying to build Qemu 2.12.0 on Fedora 31 with GCC 9.2.1 as this
particular qemu version is the only one working for my
qemu-systems-ppc64 emulation I need

./configure runs with no problem but running make breaks at this point.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
If you try to build an old QEMU on a new distro like this
you're likely to run a bunch of minor build bugs that have
been fixed in mainline. You will probably need to trawl through
the git history or the mailing list archives to find the
relevant commits which fix them (searching for error messages
is often a good tactic).

You should also choose configure options to minimise the
amount of source you build that you don't need. If you
only need qemu-system-ppc64, then pass configure the
"--target-list=ppc64-softmmu" argument and it will build
only that and won't try to build the linux-user code at all.
If configure of that vintage supports --disable-tools that
is also going to be useful (and if some bit of source that
looks uninteresting fails check to see if there's a relevant
--disable-something to just stop building it.)

thanks
-- PMM
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------AF7AE11C095C9B3703FBB14D
Content-Type: image/png;
 name="pnkicpffcfkdfano.png"
Content-Transfer-Encoding: base64
Content-ID: <part1.535F5C69.D58C9F58@yahoo.com>
Content-Disposition: inline;
 filename="pnkicpffcfkdfano.png"

iVBORw0KGgoAAAANSUhEUgAAAj0AAAA3CAYAAADnlftOAAAABHNCSVQICAgIfAhkiAAADp5J
REFUeF7tnYuRJLkNRHUXZ4Pkg2SFZLi8kBGyQjruBjYwOUkC4Ke6ujo7YmOHxC/xwKqunc/O
b3/9+z//9xe9LiXw3//8+y9/+8e/Lq2pYiIgAiIwS0D3rFlyirsbgT/uJkh6REAEREAE7kGg
Pey0l/6Rdo95SMU6gd/0mZ51iMogAiIgAiIgAiJwfwK/31+iFIqACIiACIiACIjAOgE99Kwz
VAYREAEREAEREIE3IPDroad97db+zOq2r//6eLY3m/8uce/Wk5/tu2m/y8yl474Esvcunf37
zlDK7k/gKdfPl29kXv1mtZX4BnQl/v5H5jUKGVe2N1KHhx3nFNlHuWV7PYFd8+udqx35LQee
vUbP9rCOkfX7PY2vn8K9FTydmz8j7Iz5szSy33uKa+qe0rd+emvtHNw6unejaoe3Z8OGmJ/f
i+yYT+t7Edg1P/+m4TvckT86byOiLJZpGuWQ7dkE8Dzg2rrvnfFn03led+FDDzsAuOcPQ/Q0
iLENqcX38uBhwxqWk8Xjnq19jkx+Gz3W9vp7PiN92Xh/9EbaRxqazR54zC/Dx9eufhz1vtq/
xWNfxsjqe924l5l/L3+GB2M8mmHP5jVU+stoXPFhM17JN5qVMfCMqrWqsXef3+j84ln314tx
G8Wbv/+7fdw7oyMbO7/R7NjZwto+L9ZH3WhnfNj5YDoi7TvsTB/uZeY3YpSJt156bHyv1fns
4FTJET70ZJJZkwgPY3FYHmTPxvazezgoH2cfR7nQ3tb+hfZmy+5lfKNceAgjf993hs+XZsmi
Wh97zuqdYU7kftuK6lsA8/uWjGxgXFtXe/HXF/uYlE1v4fzSgc5xlGNkm6l1dczd54f6Gh+2
1+PGfHGvzRD3LB/bxz12ZtGnp4/1g7GjNdp6+Xz9dzqzmf5Yz7Pzwzll6qMPrjHn6XX401t2
4EeQMiJPNzp7UKtx6I/rHoueX2+/l6ft92JOMx5parV79Xt6e/mq/iMmLVfTZa+exp4W25/R
xHLuysNy79ib5ZOtPZvfzzBbq/nZ/C1+Ns/uc1Dpoerrz9jM+b/bGY30RHbkh/5t7f/gGZk9
s1h3Zj0zP1YHe2Y+p854pfZI1y7bls/0RGLwEEX+V9tX9Z2Mx0Pf2LBDdOrCZPXZfExTVQfL
j/2t8mV6/d7p/K+uj/0h36bPfJgt0p+xr+Zf0YVns3pGo/6Qb+RftWN+zyJz/Yzqrcb7szOq
M7KN+hvFXWHbcVai/iJ71CfGR/7evmP+lXp38L3koQdvOndo3DSwQ105RFfE4w0fa+J6N19W
v8fPLiKMGWlCX+wH7aNcM7bT+SNNp+tH+ZF3pLdqP52/qme3f8R3tV6UH+1V3rvjq/1i/Wr8
aX98P1jli3pX+98dX+0P+7n7OvzyVmugQW0gVmFYnjtDwQOOWlftmA/XmB/XzD869H5+Lb4y
R6xfiTWtmMP3MLJhr5l8LKZ6fmc0sbpsL5M748Nyt71qbHae1bx+VtH5HOnGe0ZWr6/fYzWz
n+GQ8enVrsZm/EfnPxPf09rb350zyhfZUWfFv7Hzf1quzHnGmivr0fxY3kp/FV9W6x33lj/T
g9D8mh0OGyDabN8gmh33dx86zI8HrGf3OrHntm5/sEd2QHr5LR7trH+cAfPJaMnq834Zfejj
taANtUd2prmyd3V+rIdr7D/qBeNxHcU3e+b8jPL4ePvYz3g1v+/J5x1pMhvyyF6XvXjMh+sW
V9GI8biOemT+K/V7+rGO1cD9XnzUx8iONbC/kR1tqC+yj3TdwbaqP4rHa9evW2wUfwdGqOHX
Lxyt3gwwkdb3JMDmyvZOqb+y1qkeducVk91Ef+aLuEb2rKpdebL1dvi9o+bWd6Q7su9gpxzP
IrD8mZ5n4XheN+/4JP68KaijOxBo14JeIiACn03gy0NPe2puL90cnnUoNM9nzVPdfCVg9y1x
+U5A9/TvTLTz2QR+fXnrszGoexEQAREQAREQgacTSP301tMhqD8REAEREAEREIHnE9BDz/Nn
rA5FQAREQAREQAT+JKCHnj8htK972x+dinkC+t6KeXaKFAEREAEROE/gy4+st3L4Ta+9NzLz
Yz8y6Pci+/kW8xWY1mz0Smy2hvw4ATyjeIZ51Pfd3gx35Lccs9q+q9WOCIiACIhAlcCPn96K
HlKiGzXGV0XIXwRmCbAHFbYX5ccHG/NnudjeKD9eH9H1NMolmwiIgAiIwDyBP/AG3m7IuDef
fk8kviH5Nw1vM+2tavYzURmFo/ot3uyoxXJn4r12rz/Sx2aFe6v1M/Gmk72hj+JNa49d1P8O
O9OwI2/LgbO44/W1q1flEQEREIG7E9jynxPiwwa+ya1AwDeNlgv32AMO+sxqYHlwb/RGhr5M
f29vVrOPW62fiff8UXMmHn1wjTn9mj1kjfyZbZRjZGO5tCcCIiACInBfAqmHnvYmhK9PeTO4
qs/ZOvjAVXlg8DOt1K/44rlh6535ZvtnutjebP7ZOKZBeyIgAiIgAnMEUg892TelrF9VKnvo
quZY8X91/RXtLXZFvz1UeQ2n5rzSp/V4Sttq/lO6VpgpVgREQAQ+jUDqoScD5eRN/WTuqDf2
L/SVh4io3gn7Kj+MZ0xO6M7mPK3ndP5sn/ITAREQARFYI/A7/kv+HW7wKw8dK7EN9Wr82rh4
tM0wO7tKDxVfru7s7omeveLV/O94fZ2dmLKLgAiIwOsI/PhMj78x47/qm5298TE/1gbe9K0e
82V7u+MxH/bm180X/W2Nb4bMD9laf1l2jEd1D3Xt5l/lV62f6Rc1VGv4ePvYz2g1v5/BlbPP
sJOPCIiACHwSgS+/cBTfyD8JhHoVAREQAREQARF4NoFvv2Wd/Uv32QjUnQiIgAiIgAiIwCcQ
+PbQ8wlNq0cREAEREAEREIHPI6BfOPp5M1fHIiACIiACIvCRBPTQ85FjV9MiIAIiIAIi8HkE
9NDzeTNXxyIgAiIgAiLwkQTe6qGH/ehwNLWZmCjnyD5TbyZmpEG26wjsnN3OXNcR+PlfWjTt
Pf1m69l3a72qTk/3zvo7c/X0av8ngXdhfbXOq6/f0+fx1//IbCDv/P+InNTW+l/NP5vD/h+X
2fp4EbA80XxH9kz+0UHNxI/qW27GF3ObL2PANK7Gs5yze1nNs/lZHOu/qsP8Wa5WM7IzXZ+2
x872lQx6119mpnhefC+sL7bX65XVx3q92Or+qbxNR6Xnqu7T/k+7fn889ESH9DTUJ+R/1aFm
dXEvmu/IjrnwvESzy8SP6lv+5sNe7EbV82XxbY/l6Pk+cR/7ZzN7Yt/q6SeB6PrD84HcMB7t
q2usr/O5SvSz4//AA9QOGO7hm4g/hObrfZjdY2b5ra75YQ62b3tYG/M3P/RBPZGP969+POLn
+2K6q7XQH3PifCM75tu9ztQ3H+TItGA+5lPdw7p4E275vA/amf7Z891qsfy+J7RX+0X/TP8Y
U1lH+Vf5RVpG9aPaLfdo9lFtHz/Kk7W1fJX5W3+mE+8PGf2v9olmNJqv599jV4lnOSx+NMMR
wyhupA/na/327j9M/0gb8sP4aDZRvNfb4zDqn2mnv3AUgeBFhCCjNSuMe5jD260+NueBmH/W
x/e0eqGPtDMb20Me2TXOJhuX9cP8Ve0Yn63L5j8TuxrD+sW9aN00oA/rr/ngi8X5vciO+arr
u+RnOhhXxnDUM8uLe6M1s43qMVt0/2E1/D0RrzH0ZzV37pn+ltN/vLNGlKvXM9vHPc8S66Bv
s/u9yO6Z4JywFltj/rb2L7SjPpbz6njUWOU36glzj3ytb/rQE4FC+2iYeEEzkS3fKAfWG63Z
Rbcr96huxXZST49vb990Z+w75tSr09uvcJ3N0eLwZTPKzGqXD2rorTP1erFsH/vfnZ/VtL1s
rYof9rNaP1u71Wm+lfojbVVGmVwzPqyfCpOZmj4G67PabG+17mz8SS3V82X+pmn2HjnLosXt
4FHJEflueehZAaLYPQTsxtAbeG/fqmft7KLJ3JRW9e2hxLNEvWN/PMvrdlf1Yf8449X8EZnT
+e9eP9IX2U/zw/PR05P168X39k/l7dXD/dN8sV51vapvNb6qF/1X6rezgfHReaEPPS1JFIjC
tX4dgZPzwtx2yPz5iM4K5jhB6lQNlhcvshP9VHJG/Cu5mO/J/K/m++r6jHd17+R8slruoCGr
tep3995W9a3GV3mi/2p9jGfXtK/5ewvwN/EoAAW3dfQmYDVmcrN6o71Iyyj2KttOjRHTaL6R
fZXJqr7V+rvj2ezY3u66Pl9UL7KvajuZfzX3u8evzqbFVxicvv539HO3HBHfyL7STyY3+lTf
fzF+RW/1PFb9Z7T++EyPP/j41IQXhfl7EOiDOVagYVN+3eqw2hiTqc/yZOI8P9Y35mX8snV6
fqxfr8VriDSifYf+VX0+3j5GnT02q/vYv62bDtPAfLJ1kU10vvH8YG20Z3SgBs82yo+xqD+y
Y37Gd9RDL34U4229eD/fUa5e/CiG2Vge5od7GNfsba/y8jlYLM6wUmOHvkov6LtaP4qP7KYH
/Rhn1G6cR9cU5q3MhuXHeJw9asnURx/fO9qwPmPi92bil3/LevbmkPWLmszYr6xlelZrrsZn
uMhHBERABHoEPv0e9On9987Fyv4dmb7Vr6Fg8BvUO7zYE+cddEmDCIiACGQI2D3sLvfUjGb5
iECVAP1G5mqSkb9dQP5TWiP/qo09bJyqFWkzLdX6d3wajnqVXQRE4HkEqveudyfgH/A+rfd3
n92s/uUvb80WVpwIiIAIiIAIiIAIXEng7b+8dSUs1RIBERABERABEXhfAnroed/ZSbkIiIAI
iIAIiECBwK+Hnva1TftTiP/iyr4Bju3N5r9L3Lv15Gf7btrvMnPpuC+B7L1LZ/++M5QyEbiK
wJdvZF79Rq6V+HZDWom/Cti71WFc2d6oL3yzwDlF9lFu2V5PYNf8eudqR37LgWev0bM9rGNk
/X5P4+unIAUiIAJXEPg/bfrfXb3/dQcAAAAASUVORK5CYII=
--------------AF7AE11C095C9B3703FBB14D--

--------------0CD831FCCE569CE3D4ECD43D--

