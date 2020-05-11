Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771E6C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D94520720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9rBccJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D94520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4Vp-0001ob-CR
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY4Uq-0000OK-Rk
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:13:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY4Up-0001IA-SY
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:13:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id k1so9949654wrx.4
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 02:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CNTFQmylp1vAkVe0GXgfyTMYHvX2tC/Pm8zmF5GbLJI=;
 b=Q9rBccJkxJPU2xrzEi2/w0Tap07atnwMH7cmhQO5AeH0otI85W373WCLuvuIwrSJ11
 eUc14husfWJ95NkpaqksJleqPSeSUVFMrRoghzVtwQiXBkwSeEyLH35Bel4m4XsXyTeM
 x2veYLqpDV//2cB8LJlfukXGzexBg2vao9Z1ZVX0EvIqGG8LXngLp9or9VhwmrxJAbg1
 AbHnwQHY3W76J5CfB6tDBAR+ZutzYnvvC7VJhzY9vevAm4wmoxXIRfy3ALvuTmXnL/ZL
 etVOQxa32bmwx9sHcsS6Su35J0W7ZO55koTmPm12vjdU03ggauFFU6kmuL+PJvtvuuKX
 Yk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CNTFQmylp1vAkVe0GXgfyTMYHvX2tC/Pm8zmF5GbLJI=;
 b=XRKuAnVn76P+yEZy3wcLqsvYZqV/0yBhrlrDfYrjYsyIk4qmJK4zN1r7KEKS6bSxae
 tPY6qMAg82nf7mdp1NvHV3fC8Nutqf3EYtzYLTGuSocfmBO8DztsKiZgkatP/hH0kZI7
 wxuKTzTVQh+bSfqbofxftR+xi0bXthb6H86tlwhC84DQTcHzlaksAkAC/yRqpco15H3f
 PBytMPVzUi9idhytjHfV+q3obgu8k1dpz6nPTH72OMUGVd7BrgNE9BpCVbHxNqEf4c1E
 BoXEF9E4WrRnow2cK5FoUvJ23Itv5435qzRX7/b9GzqrnxFIrJ+38S2c37HzLWeHne+H
 PD2A==
X-Gm-Message-State: AGi0PuZlDApU2S+502EfjKI5lgkP/qJZjjXXGgKLo5MBWrlYUunXKhj1
 idgZ1supmT+8HHHRiXM/mYxAtA==
X-Google-Smtp-Source: APiQypJGk3EuEC7MfkkzPiy37f+9uhdVsuNQH+ktoFO2UGcqR57VvqcG/qBmJYfwjXRnleMa5ooA8g==
X-Received: by 2002:adf:e9d0:: with SMTP id l16mr17118451wrn.69.1589188389437; 
 Mon, 11 May 2020 02:13:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e22sm1229855wrc.41.2020.05.11.02.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 02:13:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4E8DE1FF7E;
 Mon, 11 May 2020 10:13:07 +0100 (BST)
References: <20200312142728.12285-1-robert.foley@linaro.org>
 <20200312142728.12285-5-robert.foley@linaro.org>
User-agent: mu4e 1.4.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v4 04/10] tests/vm: add --boot-console switch
In-reply-to: <20200312142728.12285-5-robert.foley@linaro.org>
Date: Mon, 11 May 2020 10:13:06 +0100
Message-ID: <87mu6erg0t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Added ability to view console during boot via
> --boot-console switch to basevm.py.  This helps debug issues that occur
> during the boot sequence.
> Also added a new special variable to vm-build:
> BOOT_CONSOLE=3D1 will cause this new --boot-console switch to be set.

Hmm why isn't this output covered by DEBUG=3D1? I'm wary of adding another
debug knob rather than just including the extra information under our
existing DEBUG output.

> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  tests/vm/Makefile.include |  4 ++++
>  tests/vm/basevm.py        | 11 +++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 78a2de1f82..d921ee14cf 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -40,6 +40,7 @@ endif
>  	@echo '    EXTRA_CONFIGURE_OPTS=3D"..."'
>  	@echo "    J=3D[0..9]*            	 - Override the -jN parameter for ma=
ke commands"
>  	@echo "    DEBUG=3D1              	 - Enable verbose output on host and=
 interactive debugging"
> +	@echo "    BOOT_CONSOLE=3D1        	 - Show the console output at boot =
time. "
>  	@echo "    V=3D1				 - Enable verbose ouput on host and guest commands"
>  	@echo "    QEMU=3D/path/to/qemu		 - Change path to QEMU binary"
>  	@echo "    QEMU_IMG=3D/path/to/qemu-img	 - Change path to qemu-img tool"
> @@ -62,6 +63,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
>  	$(call quiet-command, \
>  		$(PYTHON) $< \
>  		$(if $(V)$(DEBUG), --debug) \
> +		$(if $(BOOT_CONSOLE),--boot-console) \
>  		--image "$@" \
>  		--force \
>  		--build-image $@, \
> @@ -76,6 +78,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
>  		$(if $(DEBUG), --interactive) \
>  		$(if $(J),--jobs $(J)) \
>  		$(if $(V),--verbose) \
> +		$(if $(BOOT_CONSOLE),--boot-console) \
>  		--image "$<" \
>  		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
>  		--snapshot \
> @@ -96,6 +99,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
>  	$(call quiet-command, \
>  		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
>  		$(if $(J),--jobs $(J)) \
> +		$(if $(BOOT_CONSOLE),--boot-console) \
>  		--image "$<" \
>  		--interactive \
>  		false, \
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index dd545d3d1d..aab3d98edf 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -85,8 +85,10 @@ class BaseVM(object):
>      # 4 is arbitrary, but greater than 2,
>      # since we found we need to wait more than twice as long.
>      tcg_ssh_timeout_multiplier =3D 4
> -    def __init__(self, debug=3DFalse, vcpus=3DNone, config=3DNone):
> +    def __init__(self, debug=3DFalse, vcpus=3DNone, config=3DNone,
> +                 boot_console=3DNone):
>          self._guest =3D None
> +        self._boot_console =3D boot_console
>          # Allow input config to override defaults.
>          self._config =3D DEFAULT_CONFIG.copy()
>          if config !=3D None:
> @@ -535,6 +537,8 @@ def parse_args(vmcls):
>      parser.add_option("--config", "-c", default=3DNone,
>                        help=3D"Provide config yaml for configuration. "\
>                             "See config_example.yaml for example.")
> +    parser.add_option("--boot-console", action=3D"store_true",
> +                      help=3D"Show console during boot. ")
>      parser.disable_interspersed_args()
>      return parser.parse_args()
>=20=20
> @@ -549,7 +553,8 @@ def main(vmcls, config=3DNone):
>          config =3D parse_config(config, args)
>          logging.basicConfig(level=3D(logging.DEBUG if args.debug
>                                     else logging.WARN))
> -        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs, config=3Dcon=
fig)
> +        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs, config=3Dcon=
fig,
> +                   boot_console=3Dargs.boot_console)
>          if args.build_image:
>              if os.path.exists(args.image) and not args.force:
>                  sys.stderr.writelines(["Image file exists: %s\n" % args.=
image,
> @@ -569,6 +574,8 @@ def main(vmcls, config=3DNone):
>          if args.snapshot:
>              img +=3D ",snapshot=3Don"
>          vm.boot(img)
> +        if vm._boot_console:
> +            vm.wait_boot()
>          vm.wait_ssh()
>      except Exception as e:
>          if isinstance(e, SystemExit) and e.code =3D=3D 0:


--=20
Alex Benn=C3=A9e

