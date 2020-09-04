Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BE7C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4917C20C09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4917C20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEC1E-0003ZI-GW
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEByI-0007WM-0e
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:41:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEByF-00064S-Jz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:41:41 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-mSWziQuTOU6WtlP8VBuM1w-1; Fri, 04 Sep 2020 09:41:37 -0400
X-MC-Unique: mSWziQuTOU6WtlP8VBuM1w-1
Received: by mail-wr1-f70.google.com with SMTP id x15so1501439wrm.7
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 06:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=EsaUEID8sXWLbDAlgpxx9ibc7q6qTw5nUaimjO39UYs=;
 b=hit3yaHNAivpTyd6VA1K+yvvl5xVjFB5dxmi+XTQBd3p67356qnzVTU0s99PhPEyS5
 k7UXnguTCd8S63bDJpp3/p4FZ6MsDo/0jJQqbMkkYCGGcRynzmnSf1ibJnh39cn37cgI
 9fY7BnK3rwiloJEvVZGy+cA9zqC9XyKz9DyCJCv5QCKhsdRGgo5wd4IjzcrGrz924TgU
 KKb8ri6ISpA8snQ8YJqSgAgfQ+LCvRZSpE4WD0zdo/4Seu97D7JUfU6M0+ylZdaLPEZg
 XumK5070yAQHMwgWXMVqj68sSwFKI/f9u/nDOvziC5o2CDvNjyF0QL1R0/2B0WTxFdot
 q5iQ==
X-Gm-Message-State: AOAM531l7XGzxENtfao+T7YDY4/twlUVZ5mPmMFnVcJHiWru3sLBzW0Q
 KVSYMCziDQabN9QpQqzME3jBj0UOOpN1eLQ8MnnrFjht5htbedfiuGcwy+0Sfic4HZHpjrwbOUI
 VrxQDeifAnR8fRag=
X-Received: by 2002:adf:e58b:: with SMTP id l11mr8235070wrm.210.1599226896203; 
 Fri, 04 Sep 2020 06:41:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4YObwBDJlb5OgoqiIxYRscOdl335xw+/UNWyZBLY2tBeHbClDfwuBAmKkryriUbhls1c5Hg==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr8235048wrm.210.1599226895937; 
 Fri, 04 Sep 2020 06:41:35 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id g7sm12753751wrv.82.2020.09.04.06.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 06:41:35 -0700 (PDT)
Subject: Re: [PATCH 2/2] vhost-vdpa: improve error reporting
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200903185327.774708-1-lvivier@redhat.com>
 <20200903185327.774708-3-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <8085ec62-737d-6596-bd00-78ebf6ac001f@redhat.com>
Date: Fri, 4 Sep 2020 15:41:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903185327.774708-3-lvivier@redhat.com>
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 8:53 PM, Laurent Vivier wrote:
> Use Error framework to report the id of the device and the details of
> the error (vhostdev name and errno).
> 
> For instance:
> 
>  qemu-system-x86_64 ... -netdev vhost-vdpa,id=hostnet1 ...
>  hostnet1: Cannot open '/dev/vhost-vdpa-0': No such file or directory
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  net/vhost-vdpa.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 24103ef241e4..8260902334ae 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -176,7 +176,8 @@ static NetClientInfo net_vhost_vdpa_info = {
>  };
>  
>  static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
> -                               const char *name, const char *vhostdev)
> +                               const char *name, const char *vhostdev,
> +                               Error **errp)
>  {
>      NetClientState *nc = NULL;
>      VhostVDPAState *s;
> @@ -189,11 +190,15 @@ static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
>      s = DO_UPCAST(VhostVDPAState, nc, nc);
>      vdpa_device_fd = qemu_open(vhostdev, O_RDWR);
>      if (vdpa_device_fd == -1) {
> -        return -errno;
> +        error_setg_errno(errp, errno, "%s: Cannot open '%s'", name, vhostdev);
> +        return -1;
>      }
>      s->vhost_vdpa.device_fd = vdpa_device_fd;
>      ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa);
> -    assert(s->vhost_net);
> +    if (ret == -1) {
> +        error_setg(errp, "%s: Cannot add vhost-vdpa '%s'", name, vhostdev);
> +        return -1;
> +    }
>      return ret;
>  }
>  
> @@ -229,5 +234,6 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
>      }
>      return net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
>                                 opts->has_vhostdev ?
> -                               opts->vhostdev : VHOST_VDPA_DEFAULT_VHOSTDEV);
> +                               opts->vhostdev : VHOST_VDPA_DEFAULT_VHOSTDEV,
> +                               errp);
>  }
> 


