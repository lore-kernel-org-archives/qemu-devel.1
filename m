Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD7DC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E9120684
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E9120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42659 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYWKK-0000r3-7G
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 09:51:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hYWJ3-0008Nq-K1
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hYWIx-0001UI-Gp
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:50:21 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hYWIv-0000wD-AZ
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:50:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id b21so14266724oic.8
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 06:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=NTRQ6FArOEDXowCToUaBKAyC4OD8veaJOvwOPieKUZ4=;
	b=U2VKvqrYiSu7Ls+xChJ4yLdYahyEPUK9RbQ33U2bE61U22H1Hxp98Hzx7NKibfdwHU
	EFrCbYRUqlNVhpbFm7xYa0Mws6wz2Tq1sDleafKotZyrF9Ouq9K2DnRYNDxIAoIe2St+
	2dKp2nLpggSYRWY1QOCbvdalUpNj6lCJWHzlTCzJWGtzJAJwLXeCLJstI5vbLkzl51hN
	LFS5piX+1IYPrdCPj7SXA/E/KzfUo3P1FUjIpp0WmTj/1SJ8L+gn5wbIr/0AVtLuXYXP
	fu3RDwb8KK6kstrVN2eAAoB6TVM4UUz8IBxvsfXH2LAU2VpbLoMeGc0ZztWCisvv8KGr
	u0Dg==
X-Gm-Message-State: APjAAAWQM+Qns5QA8ZHhbpewqgRHqb+M3vEaz1DkHH+NboW7VS63jYvv
	TliO4sZXeqzKXCdsbZauExVW68kn1XvYVlOJIW0T6w==
X-Google-Smtp-Source: APXvYqwLEcv6Ozlu1t2AF6YSnrqoq2eecowL3o1SIALZ394tilmZQQDQto3UpLWKKS4pJ/VWGSvXc8NWyfpf34XBcxg=
X-Received: by 2002:aca:4d12:: with SMTP id a18mr6833844oib.33.1559742592425; 
	Wed, 05 Jun 2019 06:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190522082717.9354-1-kraxel@redhat.com>
	<20190522082717.9354-4-kraxel@redhat.com>
	<CAFEAcA_SwRQSxztT2_fOPjOgw8OZykC1+aH+eGaOvaj7UFMcYA@mail.gmail.com>
In-Reply-To: <CAFEAcA_SwRQSxztT2_fOPjOgw8OZykC1+aH+eGaOvaj7UFMcYA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 5 Jun 2019 15:49:41 +0200
Message-ID: <CAMxuvayj3Oo6VUh=GNREYjisXZs-tsTOZeLAJ=sE=pTRXvo41w@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.167.195
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, May 30, 2019 at 1:17 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 22 May 2019 at 09:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Add a vhost-user input backend example, based on virtio-input-host
> > device. It takes an evdev path as argument, and can be associated with
> > a vhost-user-input device via a UNIX socket:
> >
> > $ vhost-user-input -p /dev/input/eventX -s /tmp/vui.sock
> >
> > $ qemu ... -chardev socket,id=3Dvuic,path=3D/tmp/vui.sock
> >   -device vhost-user-input-pci,chardev=3Dvuic
> >
> > This example is intentionally not included in $TOOLS, and not
> > installed by default.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Message-id: 20190514104126.6294-4-marcandre.lureau@redhat.com
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> Hi; Coverity spotted a problem with this patch:
>
> > +int
> > +main(int argc, char *argv[])
> > +{
> > +    GMainLoop *loop =3D NULL;
> > +    VuInput vi =3D { 0, };
> > +    int rc, ver, fd;
> > +    virtio_input_config id;
> > +    struct input_id ids;
> > +    GError *error =3D NULL;
> > +    GOptionContext *context;
> > +
> > +    context =3D g_option_context_new(NULL);
> > +    g_option_context_add_main_entries(context, entries, NULL);
> > +    if (!g_option_context_parse(context, &argc, &argv, &error)) {
> > +        g_printerr("Option parsing failed: %s\n", error->message);
> > +        exit(EXIT_FAILURE);
> > +    }
> > +    if (opt_print_caps) {
> > +        g_print("{\n");
> > +        g_print("  \"type\": \"input\",\n");
> > +        g_print("  \"features\": [\n");
> > +        g_print("    \"evdev-path\",\n");
> > +        g_print("    \"no-grab\"\n");
> > +        g_print("  ]\n");
> > +        g_print("}\n");
> > +        exit(EXIT_SUCCESS);
> > +    }
> > +    if (!opt_evdev) {
> > +        g_printerr("Please specify an evdev path\n");
> > +        exit(EXIT_FAILURE);
> > +    }
> > +    if ((!!opt_socket_path + (opt_fdnum !=3D -1)) !=3D 1) {
> > +        g_printerr("Please specify either --fd or --socket-path\n");
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> > +    vi.evdevfd =3D open(opt_evdev, O_RDWR);
> > +    if (vi.evdevfd < 0) {
> > +        g_printerr("Failed to open evdev: %s\n", g_strerror(errno));
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> > +    rc =3D ioctl(vi.evdevfd, EVIOCGVERSION, &ver);
> > +    if (rc < 0) {
> > +        g_printerr("%s: is not an evdev device\n", argv[1]);
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> > +    if (!opt_nograb) {
> > +        rc =3D ioctl(vi.evdevfd, EVIOCGRAB, 1);
> > +        if (rc < 0) {
> > +            g_printerr("Failed to grab device\n");
> > +            exit(EXIT_FAILURE);
> > +        }
> > +    }
> > +
> > +    vi.config =3D g_array_new(false, false, sizeof(virtio_input_config=
));
> > +    memset(&id, 0, sizeof(id));
> > +    ioctl(vi.evdevfd, EVIOCGNAME(sizeof(id.u.string) - 1), id.u.string=
);
>
> CID 1401704 -- we don't check the return value from ioctl().

ok, I'll send a fix

>
> > +    id.select =3D VIRTIO_INPUT_CFG_ID_NAME;
> > +    id.size =3D strlen(id.u.string);
> > +    g_array_append_val(vi.config, id);
> > +
> > +    if (ioctl(vi.evdevfd, EVIOCGID, &ids) =3D=3D 0) {
> > +        memset(&id, 0, sizeof(id));
> > +        id.select =3D VIRTIO_INPUT_CFG_ID_DEVIDS;
> > +        id.size =3D sizeof(struct virtio_input_devids);
> > +        id.u.ids.bustype =3D cpu_to_le16(ids.bustype);
> > +        id.u.ids.vendor  =3D cpu_to_le16(ids.vendor);
> > +        id.u.ids.product =3D cpu_to_le16(ids.product);
> > +        id.u.ids.version =3D cpu_to_le16(ids.version);
> > +        g_array_append_val(vi.config, id);
> > +    }
> > +
> > +    vi_bits_config(&vi, EV_KEY, KEY_CNT);
> > +    vi_bits_config(&vi, EV_REL, REL_CNT);
> > +    vi_bits_config(&vi, EV_ABS, ABS_CNT);
> > +    vi_bits_config(&vi, EV_MSC, MSC_CNT);
> > +    vi_bits_config(&vi, EV_SW,  SW_CNT);
> > +    g_debug("config length: %u", vi.config->len);
> > +
> > +    if (opt_socket_path) {
> > +        int lsock =3D unix_listen(opt_socket_path, &error_fatal);
> > +        fd =3D accept(lsock, NULL, NULL);
> > +        close(lsock);
>
> This is CID 1401705 -- failure to check return value from
> unix_listen() -- which I just realised I probably replied
> to the wrong version of the patch to point out, so I mention
> it again here.

coverity should realize that passing &error_fatal will not return, no?

Can we mark this as false-positive?

>
> > +    } else {
> > +        fd =3D opt_fdnum;
> > +    }
>
> thanks
> -- PMM

