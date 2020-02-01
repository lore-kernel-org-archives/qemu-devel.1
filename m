Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACF8C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 16:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE24206E3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 16:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufbrppPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE24206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixvLC-0004wo-UW
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 11:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixvKc-0004Jh-DO
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 11:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixvKb-0008JX-0T
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 11:09:14 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixvKY-0008Im-12; Sat, 01 Feb 2020 11:09:10 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so12343950wru.3;
 Sat, 01 Feb 2020 08:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hf66daEhwSz8unUsUuL5N35gPWbaJ3m2PE7qZzRa32Q=;
 b=ufbrppPIT/N1iECImwNuKKiGAvwEb6PmxmSmUjvd8qptlOmYunbLGotu0ocTNZY5aU
 zSqjarUvZZMJTwjljj8tbDiI8TQ5ahinxWIkcK5WyGMaJXOXmJl+9fV2yXMV6MW6Kv/7
 Sh0LJ/bHAuR37emIMhfcuU1LeNuSVLVjHqdMROahPw8cYLX7vq/OAbUiSDN/f5zdHQRN
 sMv7vJdX97NhLNRm2XDWdVwm2Gf/ifdv7pth+i6Z536mRk6vLbbEW1jQdKWY/TBXmcAs
 8wxLIah7DNKqVwf8B5FiwmQqBbluGhqC/PBhg4+a9cPXfT9BjaOW9VggASgpcy12s3aE
 /iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hf66daEhwSz8unUsUuL5N35gPWbaJ3m2PE7qZzRa32Q=;
 b=elSrQ4bphnyQuop++3cXjQ1vk6JNkf4czDCUFY7K+hQMlL2X1HOOop3KmkQr4oR61e
 aWJRlAzRPjjTYPKdPfnppmmVhGNlPrubxzhah4w+Y+Ghv++TdtU4rPcMKQyE+xwFkv+P
 1xGTn3W4AMYV+8PGWI1av2lxgV44pGHaWwNsbCbefI1FBx2jnFAX50E5QmzPqlknVqDg
 UxrFfj9QDh47+Wzi2ak8ZZAtWZU0P3v5WLM4HRs1PRGG/2qcGYGM94Gjb8ctmq0MitbG
 WAA9J1zZW+DoXQgFRghsOtwCKCCFLsJp39+0FxlP9dAJmXBCYOxkq1wfKCdcR8KQS3YT
 QRRw==
X-Gm-Message-State: APjAAAWyajnR7pzmQ5g6huEe5pu3EoCSCiCx2OnX0mEMat8xsPxt2kNK
 rvgXNzT7BNe8+5o3LnJ+2Ak=
X-Google-Smtp-Source: APXvYqxq361UUjra1v+pRLLMCee0zIWZn/lVLvtnrEjhiFT9B4xW4k1aHecV6/rMqINyF6OJ351FCA==
X-Received: by 2002:adf:f986:: with SMTP id f6mr798450wrr.182.1580573348145;
 Sat, 01 Feb 2020 08:09:08 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id w8sm15797451wmm.0.2020.02.01.08.09.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2020 08:09:07 -0800 (PST)
Subject: Re: [PATCH for-5.0 3/4] Remove the core bluetooth code
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20191120091014.16883-1-thuth@redhat.com>
 <20191120091014.16883-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
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
Message-ID: <7a775153-f18d-e766-1d8f-33607f5fa05b@amsat.org>
Date: Sat, 1 Feb 2020 17:09:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191120091014.16883-4-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 10:10 AM, Thomas Huth wrote:
> It's been deprecated since QEMU v3.1. We've explicitly asked in the
> deprecation message that people should speak up on qemu-devel in case
> they are still actively using the bluetooth part of QEMU, but nobody
> ever replied that they are really still using it.
> 
> I've tried it on my own to use this bluetooth subsystem for one of my
> guests, but I was also not able to get it running anymore: When I was
> trying to pass-through a real bluetooth device, either the guest did
> not see the device at all, or the guest crashed.
> 
> Even worse for the emulated device: When running
> 
>  qemu-system-x86_64 -bt device:keyboard
> 
> QEMU crashes once you hit a key.
> 
> So it seems like the bluetooth stack is not only neglected, it is
> completely bitrotten, as far as I can tell. The only attention that
> this code got during the past years were some CVEs that have been
> spotted there. So this code is a burden for the developers, without
> any real benefit anymore. Time to remove it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Makefile.objs        |    2 -
>  bt-host.c            |  198 ----
>  bt-vhci.c            |  167 ----
>  configure            |   31 -
>  hw/Kconfig           |    1 -
>  hw/Makefile.objs     |    1 -
>  hw/bt/Kconfig        |    2 -
>  hw/bt/Makefile.objs  |    3 -
>  hw/bt/core.c         |  143 ---
>  hw/bt/hci-csr.c      |  512 ----------
>  hw/bt/hci.c          | 2263 ------------------------------------------
>  hw/bt/hid.c          |  553 -----------
>  hw/bt/l2cap.c        | 1367 -------------------------
>  hw/bt/sdp.c          |  989 ------------------
>  include/hw/bt.h      | 2177 ----------------------------------------
>  include/sysemu/bt.h  |   20 -
>  qemu-deprecated.texi |    7 -
>  qemu-options.hx      |   79 --
>  vl.c                 |  136 ---
>  19 files changed, 8651 deletions(-)
>  delete mode 100644 bt-host.c
>  delete mode 100644 bt-vhci.c
>  delete mode 100644 hw/bt/Kconfig
>  delete mode 100644 hw/bt/Makefile.objs
>  delete mode 100644 hw/bt/core.c
>  delete mode 100644 hw/bt/hci-csr.c
>  delete mode 100644 hw/bt/hci.c
>  delete mode 100644 hw/bt/hid.c
>  delete mode 100644 hw/bt/l2cap.c
>  delete mode 100644 hw/bt/sdp.c
>  delete mode 100644 include/hw/bt.h
>  delete mode 100644 include/sysemu/bt.h
> 
[...]> diff --git a/configure b/configure
> index 6099be1d84..ecce4ada2d 100755
> --- a/configure
> +++ b/configure
> @@ -349,7 +349,6 @@ unset target_list_exclude
>  # Distributions want to ensure that several features are compiled in, and it
>  # is impossible without a --enable-foo that exits if a feature is not found.
>  
> -bluez=""
>  brlapi=""
>  curl=""
>  curses=""
> @@ -1151,10 +1150,6 @@ for opt do
>    ;;
>    --enable-brlapi) brlapi="yes"
>    ;;
> -  --disable-bluez) bluez="no"
> -  ;;
> -  --enable-bluez) bluez="yes"
> -  ;;

Now than I'm bisecting over this commit, I realize removing this
option was not a good idea, we should have done like commit
cb6414dfec8 or 315d3184525:

  @@ -886,10 +885,6 @@ for opt do
  -  --disable-uuid) uuid="no"
  -  ;;
  -  --enable-uuid) uuid="yes"
  -  ;;
  ...
  +  --enable-uuid|--disable-uuid)
  +      echo "$0: $opt is obsolete, UUID support is always built" >&2
  +  ;;

>    --disable-kvm) kvm="no"
>    ;;
>    --enable-kvm) kvm="yes"
> @@ -1762,7 +1757,6 @@ disabled with --disable-FEATURE, default is enabled if available:
>    curl            curl connectivity
>    membarrier      membarrier system call (for Linux 4.14+ or Windows)
>    fdt             fdt device tree
> -  bluez           bluez stack connectivity
>    kvm             KVM acceleration support
>    hax             HAX acceleration support
>    hvf             Hypervisor.framework acceleration support
> @@ -3665,26 +3659,6 @@ EOF
>    fi
>  fi # test "$curl"
>  
> -##########################################
> -# bluez support probe
> -if test "$bluez" != "no" ; then
> -  cat > $TMPC << EOF
> -#include <bluetooth/bluetooth.h>
> -int main(void) { return bt_error(0); }
> -EOF
> -  bluez_cflags=$($pkg_config --cflags bluez 2>/dev/null)
> -  bluez_libs=$($pkg_config --libs bluez 2>/dev/null)
> -  if compile_prog "$bluez_cflags" "$bluez_libs" ; then
> -    bluez=yes
> -    libs_softmmu="$bluez_libs $libs_softmmu"
> -  else
> -    if test "$bluez" = "yes" ; then
> -      feature_not_found "bluez" "Install bluez-libs/libbluetooth devel"
> -    fi
> -    bluez="no"
> -  fi
> -fi
> -
>  ##########################################
>  # glib support probe
>  
> @@ -6509,7 +6483,6 @@ if test "$xen" = "yes" ; then
>    echo "xen ctrl version  $xen_ctrl_version"
>  fi
>  echo "brlapi support    $brlapi"
> -echo "bluez  support    $bluez"
>  echo "Documentation     $docs"
>  echo "PIE               $pie"
>  echo "vde support       $vde"
> @@ -6933,10 +6906,6 @@ if test "$brlapi" = "yes" ; then
>    echo "CONFIG_BRLAPI=y" >> $config_host_mak
>    echo "BRLAPI_LIBS=$brlapi_libs" >> $config_host_mak
>  fi
> -if test "$bluez" = "yes" ; then
> -  echo "CONFIG_BLUEZ=y" >> $config_host_mak
> -  echo "BLUEZ_CFLAGS=$bluez_cflags" >> $config_host_mak
> -fi
>  if test "$gtk" = "yes" ; then
>    echo "CONFIG_GTK=m" >> $config_host_mak
>    echo "GTK_CFLAGS=$gtk_cflags" >> $config_host_mak
[...]

