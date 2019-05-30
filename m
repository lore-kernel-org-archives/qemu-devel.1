Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E21C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C349325816
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHHSKdyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C349325816
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52280 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWJ42-0002oh-2V
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:17:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJ3E-0002Xw-5L
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJ3C-0004t2-Uk
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:16:52 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:33155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWJ3C-0004qK-Ox
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:16:50 -0400
Received: by mail-oi1-x233.google.com with SMTP id q186so4652362oia.0
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 04:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Lq0fwEN0xJ4DD7kvFE3X7xj8ONUEVU2eSSsbDEOJqew=;
	b=PHHSKdyYASMb+1NzUchdvSUZHG8MhhoHYS0hAD1BEBQJ1SttcpVM0zMPn5mEIoL5Rg
	t9r3EgQfY8Kzc7YJHjf55J+4PmhLvgCrnFDo6p0qjt+Zp9X4ejTcFRA+/2OOACudgrbL
	gdNeZxlGALuwKZRI+h/g3h3b7R8jUOJXTmf+lgqiBmEBkLurRAsKRPQnVWrqHP5qed3F
	ZiUlDGB1jklyLzmDqvdl/wQbASCVUR1B+MhWHATZAg3myFV7DdIVhrEEFMsRy/f3lqrf
	blD6bTEPdoNjNr7Ak5gchlcR/FTlkI4oZrnsB+9KB5MIXHlbIQIJOVMM1sPmS3Uj8X58
	OvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Lq0fwEN0xJ4DD7kvFE3X7xj8ONUEVU2eSSsbDEOJqew=;
	b=HtTtgUfTJ5JSoAFbzB/uekVI3u939V5KfMDN2kNAw1FNwcc+Tf8238JsyzvD6cef7q
	AA22wkkZKSqif3DLvgKyG0xApdga4Q0V0A/VWPzHyh3KraRPk2Pa9rKypcTpiKfpc3zH
	YWOXkor+cYEs/3+sDUcP3FZBoRgl7ZWX6V8hDl7b5nd3EzJ624vMomWoHi59gpkiD3Qv
	GelekImVDHw7b/KR6gVHvaRcqPVGpEzgo+N3WK8Ts1Q6At/YHPqwAezqqRHt4I0PjSGl
	V9nT8IExWqaImGsRpxPKXAJS4REgO3Rv133Dc40YM8X/hWrrXLp+uS6e1m0aGX8RuLxq
	HMZQ==
X-Gm-Message-State: APjAAAUaH5sUADnOkASp1MOK8GAFMRLV29A+xaB+rvjSIEe67ISTRY6E
	39w0qTzstHQ+wJQHiELlZ9My3qFAkcDJNWJNoVUkLg==
X-Google-Smtp-Source: APXvYqyfyZMS+EcYr1xvgE7rdDiXqnBPjMMpEtrRzFgO8FUNc993zAJgPUgOAW/KBVDo6oRQ1ZP3tZgLI/LVMzjJwpg=
X-Received: by 2002:aca:845:: with SMTP id 66mr2111098oii.163.1559215009768;
	Thu, 30 May 2019 04:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190522082717.9354-1-kraxel@redhat.com>
	<20190522082717.9354-4-kraxel@redhat.com>
In-Reply-To: <20190522082717.9354-4-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 12:16:38 +0100
Message-ID: <CAFEAcA_SwRQSxztT2_fOPjOgw8OZykC1+aH+eGaOvaj7UFMcYA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::233
Subject: Re: [Qemu-devel] [PULL 3/3] contrib: add vhost-user-input
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 at 09:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Add a vhost-user input backend example, based on virtio-input-host
> device. It takes an evdev path as argument, and can be associated with
> a vhost-user-input device via a UNIX socket:
>
> $ vhost-user-input -p /dev/input/eventX -s /tmp/vui.sock
>
> $ qemu ... -chardev socket,id=3Dvuic,path=3D/tmp/vui.sock
>   -device vhost-user-input-pci,chardev=3Dvuic
>
> This example is intentionally not included in $TOOLS, and not
> installed by default.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-id: 20190514104126.6294-4-marcandre.lureau@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Hi; Coverity spotted a problem with this patch:

> +int
> +main(int argc, char *argv[])
> +{
> +    GMainLoop *loop =3D NULL;
> +    VuInput vi =3D { 0, };
> +    int rc, ver, fd;
> +    virtio_input_config id;
> +    struct input_id ids;
> +    GError *error =3D NULL;
> +    GOptionContext *context;
> +
> +    context =3D g_option_context_new(NULL);
> +    g_option_context_add_main_entries(context, entries, NULL);
> +    if (!g_option_context_parse(context, &argc, &argv, &error)) {
> +        g_printerr("Option parsing failed: %s\n", error->message);
> +        exit(EXIT_FAILURE);
> +    }
> +    if (opt_print_caps) {
> +        g_print("{\n");
> +        g_print("  \"type\": \"input\",\n");
> +        g_print("  \"features\": [\n");
> +        g_print("    \"evdev-path\",\n");
> +        g_print("    \"no-grab\"\n");
> +        g_print("  ]\n");
> +        g_print("}\n");
> +        exit(EXIT_SUCCESS);
> +    }
> +    if (!opt_evdev) {
> +        g_printerr("Please specify an evdev path\n");
> +        exit(EXIT_FAILURE);
> +    }
> +    if ((!!opt_socket_path + (opt_fdnum !=3D -1)) !=3D 1) {
> +        g_printerr("Please specify either --fd or --socket-path\n");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    vi.evdevfd =3D open(opt_evdev, O_RDWR);
> +    if (vi.evdevfd < 0) {
> +        g_printerr("Failed to open evdev: %s\n", g_strerror(errno));
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    rc =3D ioctl(vi.evdevfd, EVIOCGVERSION, &ver);
> +    if (rc < 0) {
> +        g_printerr("%s: is not an evdev device\n", argv[1]);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (!opt_nograb) {
> +        rc =3D ioctl(vi.evdevfd, EVIOCGRAB, 1);
> +        if (rc < 0) {
> +            g_printerr("Failed to grab device\n");
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
> +    vi.config =3D g_array_new(false, false, sizeof(virtio_input_config))=
;
> +    memset(&id, 0, sizeof(id));
> +    ioctl(vi.evdevfd, EVIOCGNAME(sizeof(id.u.string) - 1), id.u.string);

CID 1401704 -- we don't check the return value from ioctl().

> +    id.select =3D VIRTIO_INPUT_CFG_ID_NAME;
> +    id.size =3D strlen(id.u.string);
> +    g_array_append_val(vi.config, id);
> +
> +    if (ioctl(vi.evdevfd, EVIOCGID, &ids) =3D=3D 0) {
> +        memset(&id, 0, sizeof(id));
> +        id.select =3D VIRTIO_INPUT_CFG_ID_DEVIDS;
> +        id.size =3D sizeof(struct virtio_input_devids);
> +        id.u.ids.bustype =3D cpu_to_le16(ids.bustype);
> +        id.u.ids.vendor  =3D cpu_to_le16(ids.vendor);
> +        id.u.ids.product =3D cpu_to_le16(ids.product);
> +        id.u.ids.version =3D cpu_to_le16(ids.version);
> +        g_array_append_val(vi.config, id);
> +    }
> +
> +    vi_bits_config(&vi, EV_KEY, KEY_CNT);
> +    vi_bits_config(&vi, EV_REL, REL_CNT);
> +    vi_bits_config(&vi, EV_ABS, ABS_CNT);
> +    vi_bits_config(&vi, EV_MSC, MSC_CNT);
> +    vi_bits_config(&vi, EV_SW,  SW_CNT);
> +    g_debug("config length: %u", vi.config->len);
> +
> +    if (opt_socket_path) {
> +        int lsock =3D unix_listen(opt_socket_path, &error_fatal);
> +        fd =3D accept(lsock, NULL, NULL);
> +        close(lsock);

This is CID 1401705 -- failure to check return value from
unix_listen() -- which I just realised I probably replied
to the wrong version of the patch to point out, so I mention
it again here.

> +    } else {
> +        fd =3D opt_fdnum;
> +    }

thanks
-- PMM

