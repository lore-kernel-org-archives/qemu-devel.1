Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB1DC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5BF206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/VsBlHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5BF206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLtUN-0004Nf-Dv
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLtTn-0003ww-VF
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:34:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLtTl-00066u-6W
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:34:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id v12so170869wmh.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 12:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=b7RpyfbuklvBxu+enOQIS0TyaSYBnO95rZCAVVU+hu0=;
 b=E/VsBlHgABHNkKKli4ySbmNuu503rCKdvAn+7tGlmMVaU703R8RNL5ObQfMQp/7hkC
 ggcLruF1G680riI3SqR6FedBCyTiC9hqWxSurpc1IOAu/pdYLK6tegPabXTGh/3gxPpw
 qbtIdSpEXyFm/+XnEEODBgoZOzn9B2DE4j490j93YyyUisX2yvh5XK1Lm5d94cYYwoq4
 SafrVNR84xPHEd/Ss9otAqnB3hvdg7mMbe5D5scBypm5QIskvNQFWPEcGlUh5aNc4cpC
 D4c1YUu3qTj+CvF5xXtYxAwTDccNVfMLvBizF9zf2IVFMtqKXxCMhlj2cSlM8wWFRTXo
 m4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=b7RpyfbuklvBxu+enOQIS0TyaSYBnO95rZCAVVU+hu0=;
 b=UK/WV035I6FxRROwSJ+yoS+L9MhYxM1gd5Mannejkzrs/ExeFy6V2vB/6vZBcuUbms
 h90jN3zyjFZizhS1lHm8MefLlURtlhO76uhjMnYL9BNQ1m8Ze/ZvZSBI4wCZcrkntCIs
 ggDX1cqh6SZxZTuiwAZ/SLOBqYPPb59U9JswVXdddbwhC+r98wk0rylKALFnmen71HhT
 1w9kVZoFFLZ2Q9Ty4NM5vADHrL9THz9iPEO2MuRKZIF6nM79YTS4KY3G4LJyo30Fylte
 6OvzNet1LbGNuCEYoFcKwIjLwzR6npYq7xpoNzNkwvKI7A4qfX4aqc/PUAftq7nVoAU9
 xiGQ==
X-Gm-Message-State: AOAM530X3WxCcnSfeak96hGKQjZjV5IWGFt+U8Aat2WLjoEs4JQlLDHx
 CKwzL5qtvWkUo55Y0AUhDZw1JsTqaLMzWQ==
X-Google-Smtp-Source: ABdhPJzphzZVP5eBWI60VRTm4NufU5zOD5A91nZat8IUtp2C82T34ShMf68RUN081wJ2K1JCth1FOg==
X-Received: by 2002:a1c:1902:: with SMTP id 2mr175751wmz.26.1601062438824;
 Fri, 25 Sep 2020 12:33:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u186sm38608wmu.34.2020.09.25.12.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 12:33:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B0E0B1FF7E;
 Fri, 25 Sep 2020 20:33:55 +0100 (BST)
References: <20200925154027.12672-1-alex.bennee@linaro.org>
 <20200925154027.12672-4-alex.bennee@linaro.org>
 <f5fc27fa-0c02-b1a9-7f29-dd48aa40fd6a@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 03/15] meson: move libmpathpersist test
In-reply-to: <f5fc27fa-0c02-b1a9-7f29-dd48aa40fd6a@redhat.com>
Date: Fri, 25 Sep 2020 20:33:55 +0100
Message-ID: <873635mz18.fsf@linaro.org>
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/09/20 17:40, Alex Benn=C3=A9e wrote:
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>=20
>> This is the first compiler/linker test that has been moved to Meson.
>> Add more section headings to keep things clearer.
>>=20
>> [thuth: Add check for mpathpersist.found() before showing mpathpersist_n=
ew_api]
>>=20
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Message-Id: <20200918103430.297167-3-thuth@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  configure         | 77 +++-----------------------------------------
>>  meson.build       | 82 ++++++++++++++++++++++++++++++++++++++++++-----
>>  meson_options.txt |  2 ++
>>  3 files changed, 80 insertions(+), 81 deletions(-)
>>=20
>> diff --git a/configure b/configure
>> index 48bf437021f6..b81868cf0231 100755
>> --- a/configure
>> +++ b/configure
>> @@ -403,7 +403,7 @@ netmap=3D"no"
>>  sdl=3D"auto"
>>  sdl_image=3D"auto"
>>  virtfs=3D""
>> -mpath=3D""
>> +mpath=3D"auto"
>>  vnc=3D"enabled"
>>  sparse=3D"no"
>>  vde=3D""
>> @@ -1116,9 +1116,9 @@ for opt do
>>    ;;
>>    --enable-virtfs) virtfs=3D"yes"
>>    ;;
>> -  --disable-mpath) mpath=3D"no"
>> +  --disable-mpath) mpath=3D"disabled"
>>    ;;
>> -  --enable-mpath) mpath=3D"yes"
>> +  --enable-mpath) mpath=3D"enabled"
>>    ;;
>>    --disable-vnc) vnc=3D"disabled"
>>    ;;
>> @@ -3848,57 +3848,6 @@ if test "$modules" =3D yes; then
>>      fi
>>  fi
>>=20=20
>> -##########################################
>> -# libmpathpersist probe
>> -
>> -if test "$mpath" !=3D "no" ; then
>> -  # probe for the new API
>> -  cat > $TMPC <<EOF
>> -#include <libudev.h>
>> -#include <mpath_persist.h>
>> -unsigned mpath_mx_alloc_len =3D 1024;
>> -int logsink;
>> -static struct config *multipath_conf;
>> -extern struct udev *udev;
>> -extern struct config *get_multipath_config(void);
>> -extern void put_multipath_config(struct config *conf);
>> -struct udev *udev;
>> -struct config *get_multipath_config(void) { return multipath_conf; }
>> -void put_multipath_config(struct config *conf) { }
>> -
>> -int main(void) {
>> -    udev =3D udev_new();
>> -    multipath_conf =3D mpath_lib_init();
>> -    return 0;
>> -}
>> -EOF
>> -  if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
>> -    mpathpersist=3Dyes
>> -    mpathpersist_new_api=3Dyes
>> -  else
>> -    # probe for the old API
>> -    cat > $TMPC <<EOF
>> -#include <libudev.h>
>> -#include <mpath_persist.h>
>> -unsigned mpath_mx_alloc_len =3D 1024;
>> -int logsink;
>> -int main(void) {
>> -    struct udev *udev =3D udev_new();
>> -    mpath_lib_init(udev);
>> -    return 0;
>> -}
>> -EOF
>> -    if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
>> -      mpathpersist=3Dyes
>> -      mpathpersist_new_api=3Dno
>> -    else
>> -      mpathpersist=3Dno
>> -    fi
>> -  fi
>> -else
>> -  mpathpersist=3Dno
>> -fi
>> -
>>  ##########################################
>>  # pthread probe
>>  PTHREADLIBS_LIST=3D"-pthread -lpthread -lpthreadGC2"
>> @@ -6340,23 +6289,11 @@ if test "$softmmu" =3D yes ; then
>>        fi
>>        virtfs=3Dno
>>      fi
>> -    if test "$mpath" !=3D no && test "$mpathpersist" =3D yes ; then
>> -      mpath=3Dyes
>> -    else
>> -      if test "$mpath" =3D yes; then
>> -        error_exit "Multipath requires libmpathpersist devel"
>> -      fi
>> -      mpath=3Dno
>> -    fi
>>    else
>>      if test "$virtfs" =3D yes; then
>>        error_exit "VirtFS is supported only on Linux"
>>      fi
>>      virtfs=3Dno
>> -    if test "$mpath" =3D yes; then
>> -      error_exit "Multipath is supported only on Linux"
>> -    fi
>> -    mpath=3Dno
>>    fi
>>  fi
>>=20=20
>> @@ -6897,12 +6834,6 @@ fi
>>  if test "$virtfs" =3D "yes" ; then
>>    echo "CONFIG_VIRTFS=3Dy" >> $config_host_mak
>>  fi
>> -if test "$mpath" =3D "yes" ; then
>> -  echo "CONFIG_MPATH=3Dy" >> $config_host_mak
>> -  if test "$mpathpersist_new_api" =3D "yes"; then
>> -    echo "CONFIG_MPATH_NEW_API=3Dy" >> $config_host_mak
>> -  fi
>> -fi
>>  if test "$vhost_scsi" =3D "yes" ; then
>>    echo "CONFIG_VHOST_SCSI=3Dy" >> $config_host_mak
>>  fi
>> @@ -7992,7 +7923,7 @@ NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \
>>          -Dstrip=3D$(if test "$strip_opt" =3D yes; then echo true; else =
echo false; fi) \
>>          -Db_pie=3D$(if test "$pie" =3D yes; then echo true; else echo f=
alse; fi) \
>>          -Db_coverage=3D$(if test "$gcov" =3D yes; then echo true; else =
echo false; fi) \
>> -	-Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \
>> +	-Dmpath=3D$mpath -Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \
>>  	-Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg -Dvnc_png=
=3D$vnc_png \
>>  	-Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f\
>>          $cross_arg \
>> diff --git a/meson.build b/meson.build
>> index 48724988972d..c09d869f9b02 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -81,6 +81,14 @@ if 'SPARSE_CFLAGS' in config_host
>>                         'compile_commands.json'])
>>  endif
>>=20=20
>> +###########################################
>> +# Target-specific checks and dependencies #
>> +###########################################
>> +
>> +if targetos !=3D 'linux' and get_option('mpath').enabled()
>> +  error('Multipath is supported only on Linux')
>> +endif
>> +
>>  m =3D cc.find_library('m', required: false)
>>  util =3D cc.find_library('util', required: false)
>>  winmm =3D []
>> @@ -112,6 +120,11 @@ elif targetos =3D=3D 'haiku'
>>              cc.find_library('network'),
>>              cc.find_library('bsd')]
>>  endif
>> +
>> +################
>> +# Dependencies #
>> +################
>> +
>>  # The path to glib.h is added to all compilation commands.  This was
>>  # grandfathered in from the QEMU Makefiles.
>>  add_project_arguments(config_host['GLIB_CFLAGS'].split(),
>> @@ -218,10 +231,6 @@ if 'CONFIG_SPICE' in config_host
>>                               link_args: config_host['SPICE_LIBS'].split=
())
>>  endif
>>  rt =3D cc.find_library('rt', required: false)
>> -libmpathpersist =3D not_found
>> -if config_host.has_key('CONFIG_MPATH')
>> -  libmpathpersist =3D cc.find_library('mpathpersist')
>> -endif
>>  libdl =3D not_found
>>  if 'CONFIG_PLUGIN' in config_host
>>    libdl =3D cc.find_library('dl', required: true)
>> @@ -252,9 +261,62 @@ if 'CONFIG_CURL' in config_host
>>                              link_args: config_host['CURL_LIBS'].split())
>>  endif
>>  libudev =3D not_found
>> -if target_os =3D=3D 'linux'
>> -  libudev =3D dependency('libudev', static: enable_static)
>> +if targetos =3D=3D 'linux'
>> +  libudev =3D dependency('libudev',
>> +                       required: get_option('mpath'),
>> +                       static: enable_static)
>> +endif
>> +
>> +mpathpersist =3D not_found
>> +if targetos =3D=3D 'linux' and not get_option('mpath').disabled()
>> +  libmultipath =3D cc.find_library('multipath',
>> +                                 required: get_option('mpath'),
>> +                                 static: enable_static)
>> +  libmpathpersist =3D cc.find_library('mpathpersist',
>> +                                    required: get_option('mpath'),
>> +                                    static: enable_static)
>> +  if libmultipath.found() and libmpathpersist.found() and libudev.found=
()
>> +    if cc.links('''
>> +      #include <libudev.h>
>> +      #include <mpath_persist.h>
>> +      unsigned mpath_mx_alloc_len =3D 1024;
>> +      int logsink;
>> +      static struct config *multipath_conf;
>> +      extern struct udev *udev;
>> +      extern struct config *get_multipath_config(void);
>> +      extern void put_multipath_config(struct config *conf);
>> +      struct udev *udev;
>> +      struct config *get_multipath_config(void) { return multipath_conf=
; }
>> +      void put_multipath_config(struct config *conf) { }
>> +      int main(void) {
>> +          udev =3D udev_new();
>> +          multipath_conf =3D mpath_lib_init();
>> +          return 0;
>> +      }''', dependencies: [libmultipath, libmpathpersist, libudev])
>> +      mpathpersist =3D declare_dependency(dependencies: [libmultipath, =
libmpathpersist, libudev])
>> +      mpathpersist_new_api =3D true
>> +    elif cc.links('''
>> +      #include <libudev.h>
>> +      #include <mpath_persist.h>
>> +      unsigned mpath_mx_alloc_len =3D 1024;
>> +      int logsink;
>> +      int main(void) {
>> +          struct udev *udev =3D udev_new();
>> +          mpath_lib_init(udev);
>> +          return 0;
>> +      }''', dependencies: [libmultipath, libmpathpersist, libudev])
>> +      mpathpersist =3D declare_dependency(dependencies: [libmultipath, =
libmpathpersist, libudev])
>> +      mpathpersist_new_api =3D false
>> +    else
>> +      if get_option('mpath').enabled()
>> +        error('Cannot detect libmpathpersist API')
>> +      else
>> +        warning('Cannot detect libmpathpersist API, disabling')
>> +      endif
>> +    endif
>> +  endif
>>  endif
>> +
>>  brlapi =3D not_found
>>  if 'CONFIG_BRLAPI' in config_host
>>    brlapi =3D declare_dependency(link_args: config_host['BRLAPI_LIBS'].s=
plit())
>> @@ -436,6 +498,10 @@ has_gettid =3D cc.has_function('gettid')
>>  # Create config-host.h
>>=20=20
>>  config_host_data.set('CONFIG_LIBUDEV', libudev.found())
>> +config_host_data.set('CONFIG_MPATH', mpathpersist.found())
>> +if mpathpersist.found()
>> +  config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
>> +endif
>>  config_host_data.set('CONFIG_SDL', sdl.found())
>>  config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
>>  config_host_data.set('CONFIG_VNC', vnc.found())
>> @@ -1185,7 +1251,7 @@ if have_tools
>>=20=20
>>      executable('qemu-pr-helper', files('scsi/qemu-pr-helper.c', 'scsi/u=
tils.c'),
>>                 dependencies: [authz, crypto, io, qom, qemuutil,
>> -                              libcap_ng, libudev, libmpathpersist],
>> +                              libcap_ng, mpathpersist],
>>                 install: true)
>>    endif
>>=20=20
>> @@ -1407,7 +1473,7 @@ summary_info +=3D {'Audio drivers':     config_hos=
t['CONFIG_AUDIO_DRIVERS']}
>>  summary_info +=3D {'Block whitelist (rw)': config_host['CONFIG_BDRV_RW_=
WHITELIST']}
>>  summary_info +=3D {'Block whitelist (ro)': config_host['CONFIG_BDRV_RO_=
WHITELIST']}
>>  summary_info +=3D {'VirtFS support':    config_host.has_key('CONFIG_VIR=
TFS')}
>> -summary_info +=3D {'Multipath support': config_host.has_key('CONFIG_MPA=
TH')}
>> +summary_info +=3D {'Multipath support': mpathpersist.found()}
>>  summary_info +=3D {'VNC support':       vnc.found()}
>>  if vnc.found()
>>    summary_info +=3D {'VNC SASL support':  sasl.found()}
>> diff --git a/meson_options.txt b/meson_options.txt
>> index 543cf70043a2..b38a6ae92a92 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -6,6 +6,8 @@ option('docdir', type : 'string', value : 'doc',
>>  option('gettext', type : 'boolean', value : true,
>>         description: 'Localization of the GTK+ user interface')
>>=20=20
>> +option('mpath', type : 'feature', value : 'auto',
>> +       description: 'Multipath persistent reservation passthrough')
>>  option('sdl', type : 'feature', value : 'auto',
>>         description: 'SDL user interface')
>>  option('sdl_image', type : 'feature', value : 'auto',
>>=20
>
> This is not the latest version of the series, can you drop patches 2
> and 3?

Sure.

--=20
Alex Benn=C3=A9e

