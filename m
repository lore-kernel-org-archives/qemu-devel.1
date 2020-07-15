Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADD2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA02F20657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="pfW8bOVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA02F20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vayavyalabs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhwU-0003MK-03
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1jvhvj-0002Pb-68
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:58:39 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1jvhvh-00069D-3d
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:58:38 -0400
Received: by mail-wm1-x32f.google.com with SMTP id c80so5727403wme.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vayavyalabs.com; s=vayavyalabs;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=71vsjZyKHeQHRcgMoFDwb+YhtVO3aOMvNMfDmXy70SI=;
 b=pfW8bOVBBDHI/lkS2PPTTmyWSl650cfLbCIyucOdoH6a2zFEnsyprNzQ9c0QxVInYX
 bMIV1QKDd7UVm/yJViFxERkQKhr89qBBGaCnIbGFk3wXV5lbn5unMDmmLKLAYioVXxes
 25UukmUIddrIgnCOWTTGi8996i6klNiyanA1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=71vsjZyKHeQHRcgMoFDwb+YhtVO3aOMvNMfDmXy70SI=;
 b=ZPtFdBwV6aJNzedtPm1PHftz30VPIoQ9z8lCwed3+zoyLiv5rgNDh9Q0nqTMQ5zT+M
 kDWYlneknjHynofOUYer9Q752ONz9UsUD+ONLoegTqG+FdRjWJJHueCmZKMTrffl2bfm
 Tv8LVBS9ApUAFtj0wx3pqiDOgcEAVMCVS/r790M1WhvgwAslRwEOZ4theoKs4aQmXJIV
 +zU2h7OezU3ENnjjAcKq4OfYSEkOktY2Z6GfpXFRlKJSK8kct04BdApXvxQmN8lTADrY
 5tzbn8+eMDIjhy18DpMRV3SMPgR6SCtyhwP1RS+BbCg1lPUamexefTZfYsMX2mi424Pc
 4pgQ==
X-Gm-Message-State: AOAM533twvA0Hn4xpmiWMk+hLjW+4BfKIK1GvObx+B2LoprIgudZvcvL
 po+ERt8bC9Gd4dOXw6XY7No0gqrR4O2RlK53KN+6gA==
X-Google-Smtp-Source: ABdhPJzrl+1WdsAn3T/pRmUVqAp/RDZ/NOUkvLU5DNjjNS4OHYO9/hV3NWCOhesWzWLWDQR+CNAbSgwLaboKOFECwOM=
X-Received: by 2002:a1c:2485:: with SMTP id k127mr8580388wmk.138.1594821515412; 
 Wed, 15 Jul 2020 06:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
 <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
 <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com>
 <87365t18mp.fsf@dusky.pond.sub.org>
In-Reply-To: <87365t18mp.fsf@dusky.pond.sub.org>
From: Pratik Parvati <pratikp@vayavyalabs.com>
Date: Wed, 15 Jul 2020 19:28:24 +0530
Message-ID: <CA+aXn+Guvt34PDD=N3FsD5w1C-aDXZ7gS8H_AZN-JEM8j8wBiQ@mail.gmail.com>
Subject: Re: sysbus_create_simple Vs qdev_create
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e823d605aa7b5143"
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=pratikp@vayavyalabs.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e823d605aa7b5143
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus and Philippe,

Thanks for your reply. Now I am pretty clear about Qdev and sysbus helper
function.

Can you please explain to me in brief on buses and device hierarchies (i.e.
BusState and DeviceState) and how they are related to each other? As I can
see, the DeviceState class inherits the BusState

struct DeviceState {
    /*< private >*/
    Object parent_obj;
    /*< public >*/

    const char *id;
    char *canonical_path;
    bool realized;
    bool pending_deleted_event;
    QemuOpts *opts;
    int hotplugged;
    bool allow_unplug_during_migration;
    BusState *parent_bus; \\ BusState is inherited here
    QLIST_HEAD(, NamedGPIOList) gpios;
    QLIST_HEAD(, BusState) child_bus;
    int num_child_bus;
    int instance_id_alias;
    int alias_required_for_version;
    ResettableState reset;
};

and BusState, in turn, inherits the DeviceState as

/**
 * BusState:
 * @hotplug_handler: link to a hotplug handler associated with bus.
 * @reset: ResettableState for the bus; handled by Resettable interface.
 */struct BusState {
    Object obj;
    DeviceState *parent; \\ DeviceState is inherited here
    char *name;
    HotplugHandler *hotplug_handler;
    int max_index;
    bool realized;
    int num_children;
    QTAILQ_HEAD(, BusChild) children;
    QLIST_ENTRY(BusState) sibling;
    ResettableState reset;
};

I am a bit confused. Can you brief me this relation!

Thanks and Regards,
Pratik

On Wed, Jul 15, 2020 at 2:02 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
> > Hi Pratik,
> >
> > On 7/14/20 6:17 PM, Pratik Parvati wrote:
> >> Here is a brief context that might help you.
> >> I am referring hw/arm/versatilepb.c
> >>
> >> The ARM PrimeCell UART (PL011) device created as follows
> >>
> >>     dev =3D qdev_create(NULL, "pl011");
> >>     s =3D SYS_BUS_DEVICE(dev);
> >>     qdev_prop_set_chr(dev, "chardev", chr);
> >>     qdev_init_nofail(dev);
> >>     sysbus_mmio_map(s, 0, addr);
> >>     sysbus_connect_irq(s, 0, irq);
>
> This is pl011_create().
>
> Since recent merge commit 6675a653d2e, it's
>
>        dev =3D qdev_new("pl011");
>        s =3D SYS_BUS_DEVICE(dev);
>        qdev_prop_set_chr(dev, "chardev", chr);
>        sysbus_realize_and_unref(s, &error_fatal);
>        sysbus_mmio_map(s, 0, addr);
>        sysbus_connect_irq(s, 0, irq);
>
> >>
> >> Whereas the PL031 RTC device is created as
> >>
> >>     /* Add PL031 Real Time Clock. */
> >>     sysbus_create_simple("pl031", 0x101e8000, pic[10]);
> >>
> >> What is the difference between these two devices creation?
> >
> > Both devices inherit SysBusDevice, which itself inherits QDev.
>
> Yes: TYPE_SYS_BUS_DEVICE is a subtype of TYPE_DEVICE.
>
> > You can create QDev objects with the qdev API, and
> > SysBusDevice objects with the sysbus API.
>
> Yes.
>
> qdev_new(), qdev_realize_and_unref(), ... work with DeviceState * (the C
> type of an instance of QOM TYPE_DEVICE).
>
> sysbus_realize_and_unref(), ... work with SysBusDevice * (the C type of
> an instance of QOM TYPE_SYS_BUS_DEVICE).
>
> Since TYPE_SYS_BUS_DEVICE is a subtype of TYPE_DEVICE, you can safely
> use qdev_ functions with sysbus devices.  Example: pl011_create() uses
> qdev_new() to create a sysbus device.  That's fine.
>
> > sysbus_create_simple() is a condensed helper, but only allow you
> > to pass qemu_irq objects, not a 'chardev' property. So for this
> > case you have to use the qdev API instead.
>
> Yes.  It's a helper that combines creating a sysbus device, wiring up
> one MMIO region and one IRQ, and realizing.  If you need to configure or
> wire up more than that, you can't use it.
>
> >> How do I know
> >> which method to use while creating an object?
> >
> > SysBusDevice are plugged onto a bus. QDev aren't.
> > The sysbus API results in smaller code, easier to review.
>
> The general pattern for a stand-alone device is
>
>     dev =3D qdev_new(type_name);
>     set properties and wire up stuff...
>     qdev_realize_and_unref(dev, bus, &err);
>
> When this is to be done in device code, say to create a component
> device, the split between .instance_init() and .realize() complicates
> things.  If interested, ask and I'll explain.
>
> There are quite a few wrappers around qdev_ functions for various
> subtypes of TYPE_DEVICE.  Use them to make your code more concise and
> easier to understand.  Example: sysbus_realize_and_unref().
>
> There are also convenience functions that capture special cases of the
> entire general pattern.  Example: sysbus_create_simple().
>
> Hope this helps!
>
>

--000000000000e823d605aa7b5143
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"markdown-here-wrapper" style=3D""><p style=
=3D"margin:0px 0px 1.2em!important">Hi Markus and Philippe,</p>
<p style=3D"margin:0px 0px 1.2em!important">Thanks for your reply. Now I am=
 pretty clear about Qdev and sysbus helper function. </p>
<p style=3D"margin:0px 0px 1.2em!important">Can you please explain to me in=
 brief on buses and device hierarchies (i.e. BusState and DeviceState) and =
how they are related to each other? As I can see, the DeviceState class inh=
erits the BusState </p>
<pre style=3D"font-size:0.85em;font-family:Consolas,Inconsolata,Courier,mon=
ospace;font-size:1em;line-height:1.2em;margin:1.2em 0px"><code class=3D"hlj=
s language-C" style=3D"font-size:0.85em;font-family:Consolas,Inconsolata,Co=
urier,monospace;margin:0px 0.15em;padding:0px 0.3em;white-space:pre-wrap;bo=
rder:1px solid rgb(234,234,234);background-color:rgb(248,248,248);border-ra=
dius:3px;display:inline;white-space:pre;overflow:auto;border-radius:3px;bor=
der:1px solid rgb(204,204,204);padding:0.5em 0.7em;display:block!important;=
display:block;overflow-x:auto;padding:0.5em;color:rgb(51,51,51);background:=
rgb(248,248,248)"><span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51)=
;font-weight:bold">struct</span> DeviceState {
    <span class=3D"hljs-comment" style=3D"color:rgb(153,153,136);font-style=
:italic">/*&lt; private &gt;*/</span>
    Object parent_obj;
    <span class=3D"hljs-comment" style=3D"color:rgb(153,153,136);font-style=
:italic">/*&lt; public &gt;*/</span>

    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">const</span> <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51)=
;font-weight:bold">char</span> *id;
    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">char</span> *canonical_path;
    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">bool</span> realized;
    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">bool</span> pending_deleted_event;
    QemuOpts *opts;
    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">int</span> hotplugged;
    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">bool</span> allow_unplug_during_migration;
    BusState *parent_bus; \\ BusState is inherited here
    QLIST_HEAD(, NamedGPIOList) gpios;
    QLIST_HEAD(, BusState) child_bus;
    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">int</span> num_child_bus;
    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">int</span> instance_id_alias;
    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">int</span> alias_required_for_version;
    ResettableState reset;
};
</code></pre>
<p style=3D"margin:0px 0px 1.2em!important">and BusState, in turn, inherits=
 the DeviceState as </p>
<pre style=3D"font-size:0.85em;font-family:Consolas,Inconsolata,Courier,mon=
ospace;font-size:1em;line-height:1.2em;margin:1.2em 0px"><code class=3D"hlj=
s language-C" style=3D"font-size:0.85em;font-family:Consolas,Inconsolata,Co=
urier,monospace;margin:0px 0.15em;padding:0px 0.3em;white-space:pre-wrap;bo=
rder:1px solid rgb(234,234,234);background-color:rgb(248,248,248);border-ra=
dius:3px;display:inline;white-space:pre;overflow:auto;border-radius:3px;bor=
der:1px solid rgb(204,204,204);padding:0.5em 0.7em;display:block!important;=
display:block;overflow-x:auto;padding:0.5em;color:rgb(51,51,51);background:=
rgb(248,248,248)">
<span class=3D"hljs-comment" style=3D"color:rgb(153,153,136);font-style:ita=
lic">/**
 * BusState:
 * @hotplug_handler: link to a hotplug handler associated with bus.
 * @reset: ResettableState for the bus; handled by Resettable interface.
 */</span>
<span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:bold"=
>struct</span> BusState {
    Object obj;
    DeviceState *parent; \\ DeviceState is inherited here
    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">char</span> *name;
    HotplugHandler *hotplug_handler;
    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">int</span> max_index;
    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">bool</span> realized;
    <span class=3D"hljs-keyword" style=3D"color:rgb(51,51,51);font-weight:b=
old">int</span> num_children;
    QTAILQ_HEAD(, BusChild) children;
    QLIST_ENTRY(BusState) sibling;
    ResettableState reset;
};
</code></pre>
<p style=3D"margin:0px 0px 1.2em!important">I am a bit confused. Can you br=
ief me this relation!</p>
<p style=3D"margin:0px 0px 1.2em!important">Thanks and Regards,<br>Pratik</=
p>
<div title=3D"MDH:SGkgTWFya3VzIGFuZCBQaGlsaXBwZSw8ZGl2Pjxicj48L2Rpdj48ZGl2P=
lRoYW5rcyBmb3IgeW91
ciByZXBseS4gSSBhbSBwcmV0dHkgY2xlYXIgPHNwYW4gemV1bTRjND0iUFJfMV8wIiBkYXRhLWR=
k
bndhYj0iUFJfMV8wIiBhcmlhLWludmFsaWQ9ImdyYW1tYXIiIGNsYXNzPSJMbSBuZyI+YWJvdXQ=
g
UWRldjwvc3Bhbj4gYW5kIHN5c2J1cyBoZWxwZXIgPHNwYW4gemV1bTRjND0iUFJfMl8wIiBkYXR=
h
LWRkbndhYj0iUFJfMl8wIiBhcmlhLWludmFsaWQ9ImdyYW1tYXIiIGNsYXNzPSJMbSBuZyI+ZnV=
u
Y3Rpb248L3NwYW4+LiZuYnNwOzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Q2FuIHlvdSBwbGV=
h
c2UgZXhwbGFpbiB0byBtZSBpbiBicmllZiBvbiBidXNlcyBhbmQgZGV2aWNlIDxzcGFuIHpldW0=
0
YzQ9IjE1OTQ4MjEwMDY4OTciIGRhdGEtZGRud2FiPSIxNTk0ODIxMDA2ODk3IiBjbGFzcz0ibmc=
i
IGRhdGEtd3BrZ3Y9InRydWUiPmhpZXJhcmNoaWVzPC9zcGFuPiZuYnNwOyhpLmUuIEJ1c1N0YXR=
l
IGFuZCBEZXZpY2VTdGF0ZSkgYW5kIGhvdyB0aGV5IGFyZSByZWxhdGVkIHRvIGVhY2ggb3RoZXI=
/
IEFzIEkgY2FuIHNlZSwgdGhlJm5ic3A7RGV2aWNlU3RhdGUgY2xhc3MgaW5oZXJpdHMmbmJzcDt=
0
aGUmbmJzcDtCdXNTdGF0ZSZuYnNwOzwvZGl2PjxkaXY+YGBgQzwvZGl2PnN0cnVjdCBEZXZpY2V=
T
dGF0ZSB7PGJyPsKgIMKgIC8qJmx0OyBwcml2YXRlICZndDsqLzxicj7CoCDCoCBPYmplY3QgcGF=
y
ZW50X29iajs8YnI+wqAgwqAgLyombHQ7IHB1YmxpYyAmZ3Q7Ki88YnI+PGJyPsKgIMKgIGNvbnN=
0
IGNoYXIgKmlkOzxicj7CoCDCoCBjaGFyICpjYW5vbmljYWxfcGF0aDs8YnI+wqAgwqAgYm9vbCB=
y
ZWFsaXplZDs8YnI+wqAgwqAgYm9vbCBwZW5kaW5nX2RlbGV0ZWRfZXZlbnQ7PGJyPsKgIMKgIFF=
l
bXVPcHRzICpvcHRzOzxicj7CoCDCoCBpbnQgaG90cGx1Z2dlZDs8YnI+wqAgwqAgYm9vbCBhbGx=
v
d191bnBsdWdfZHVyaW5nX21pZ3JhdGlvbjs8YnI+wqAgwqAgQnVzU3RhdGUgKnBhcmVudF9idXM=
7
IFxcIEJ1c1N0YXRlIGlzIGluaGVyaXRlZCBoZXJlPGJyPsKgIMKgIFFMSVNUX0hFQUQoLCBOYW1=
l
ZEdQSU9MaXN0KSBncGlvczs8YnI+wqAgwqAgUUxJU1RfSEVBRCgsIEJ1c1N0YXRlKSBjaGlsZF9=
i
dXM7PGJyPsKgIMKgIGludCBudW1fY2hpbGRfYnVzOzxicj7CoCDCoCBpbnQgaW5zdGFuY2VfaWR=
f
YWxpYXM7PGJyPsKgIMKgIGludCBhbGlhc19yZXF1aXJlZF9mb3JfdmVyc2lvbjs8YnI+wqAgwqA=
g
UmVzZXR0YWJsZVN0YXRlIHJlc2V0Ozxicj59Ozxicj48ZGl2PmBgYCZuYnNwOzxicj48L2Rpdj4=
8
ZGl2PmFuZCBCdXNTdGF0ZSwgaW4gdHVybiwgaW5oZXJpdHMgdGhlJm5ic3A7RGV2aWNlU3RhdGU=
g
YXMmbmJzcDs8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmBgYEM8L2Rpdj48ZGl2Pjxicj4vKio=
8
YnI+Jm5ic3A7KiBCdXNTdGF0ZTo8YnI+Jm5ic3A7KiBAaG90cGx1Z19oYW5kbGVyOiBsaW5rIHR=
v
IGEgaG90cGx1ZyBoYW5kbGVyIGFzc29jaWF0ZWQgPHNwYW4gemV1bTRjND0iUFJfNl8wIiBkYXR=
h
LWRkbndhYj0iUFJfNl8wIiBhcmlhLWludmFsaWQ9ImdyYW1tYXIiIGNsYXNzPSJMbSBuZyI+d2l=
0
aCBidXM8L3NwYW4+Ljxicj4mbmJzcDsqIEByZXNldDogUmVzZXR0YWJsZVN0YXRlIGZvciB0aGU=
g
YnVzOyBoYW5kbGVkIGJ5IFJlc2V0dGFibGUgaW50ZXJmYWNlLjxicj4mbmJzcDsqLzxicj5zdHJ=
1
Y3QgQnVzU3RhdGUgezxicj4mbmJzcDsgJm5ic3A7IE9iamVjdCBvYmo7PGJyPiZuYnNwOyAmbmJ=
z
cDsgRGV2aWNlU3RhdGUgKnBhcmVudDs8YnI+Jm5ic3A7ICZuYnNwOyBjaGFyICpuYW1lOzxicj4=
m
bmJzcDsgJm5ic3A7IEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2hhbmRsZXI7PGJyPiZuYnNwOyA=
m
bmJzcDsgaW50IG1heF9pbmRleDs8YnI+Jm5ic3A7ICZuYnNwOyBib29sIHJlYWxpemVkOzxicj4=
m
bmJzcDsgJm5ic3A7IGludCBudW1fY2hpbGRyZW47PGJyPiZuYnNwOyAmbmJzcDsgUVRBSUxRX0h=
F
QUQoLCBCdXNDaGlsZCkgY2hpbGRyZW47PGJyPiZuYnNwOyAmbmJzcDsgUUxJU1RfRU5UUlkoQnV=
z
U3RhdGUpIHNpYmxpbmc7PGJyPiZuYnNwOyAmbmJzcDsgUmVzZXR0YWJsZVN0YXRlIHJlc2V0Ozx=
i
cj59Ozxicj5gYGA8L2Rpdj48ZGl2PkkgYW0gYSBiaXQgY29uZnVzZWQuIENhbiB5b3UgYnJpZWY=
g
PHNwYW4gemV1bTRjND0iUFJfOF8wIiBkYXRhLWRkbndhYj0iUFJfOF8wIiBhcmlhLWludmFsaWQ=
9
ImdyYW1tYXIiIGNsYXNzPSJMbSBuZyI+bWUgdGhpczwvc3Bhbj4gcmVsYXRpb24hPC9kaXY+PGR=
p
dj48YnI+PC9kaXY+PGRpdj5UaGFua3MgYW5kIFJlZ2FyZHMsPC9kaXY+PGRpdj5QcmF0aWs8L2R=
p
dj48ZGl2Pjxicj48YnI+PC9kaXY+" style=3D"height:0;width:0;max-height:0;max-wi=
dth:0;overflow:hidden;font-size:0em;padding:0;margin:0"></div></div></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed,=
 Jul 15, 2020 at 2:02 PM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto=
:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt; writes:<br>
<br>
&gt; Hi Pratik,<br>
&gt;<br>
&gt; On 7/14/20 6:17 PM, Pratik Parvati wrote:<br>
&gt;&gt; Here is a brief context that might help you.<br>
&gt;&gt; I am referring hw/arm/versatilepb.c<br>
&gt;&gt; <br>
&gt;&gt; The ARM PrimeCell UART (PL011) device created as follows<br>
&gt;&gt; <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0dev =3D qdev_create(NULL, &quot;pl011&quot;);<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0s =3D SYS_BUS_DEVICE(dev);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0qdev_prop_set_chr(dev, &quot;chardev&quot;, chr=
);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0qdev_init_nofail(dev);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(s, 0, addr);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(s, 0, irq);<br>
<br>
This is pl011_create().<br>
<br>
Since recent merge commit 6675a653d2e, it&#39;s<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0dev =3D qdev_new(&quot;pl011&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0s =3D SYS_BUS_DEVICE(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop_set_chr(dev, &quot;chardev&quot;, chr)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_realize_and_unref(s, &amp;error_fatal);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(s, 0, addr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(s, 0, irq);<br>
<br>
&gt;&gt;<br>
&gt;&gt; Whereas the PL031 RTC device is created as<br>
&gt;&gt; <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0/* Add PL031 Real Time Clock. */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0sysbus_create_simple(&quot;pl031&quot;, 0x101e8=
000, pic[10]);<br>
&gt;&gt; <br>
&gt;&gt; What is the difference between these two devices creation?<br>
&gt;<br>
&gt; Both devices inherit SysBusDevice, which itself inherits QDev.<br>
<br>
Yes: TYPE_SYS_BUS_DEVICE is a subtype of TYPE_DEVICE.<br>
<br>
&gt; You can create QDev objects with the qdev API, and<br>
&gt; SysBusDevice objects with the sysbus API.<br>
<br>
Yes.<br>
<br>
qdev_new(), qdev_realize_and_unref(), ... work with DeviceState * (the C<br=
>
type of an instance of QOM TYPE_DEVICE).<br>
<br>
sysbus_realize_and_unref(), ... work with SysBusDevice * (the C type of<br>
an instance of QOM TYPE_SYS_BUS_DEVICE).<br>
<br>
Since TYPE_SYS_BUS_DEVICE is a subtype of TYPE_DEVICE, you can safely<br>
use qdev_ functions with sysbus devices.=C2=A0 Example: pl011_create() uses=
<br>
qdev_new() to create a sysbus device.=C2=A0 That&#39;s fine.<br>
<br>
&gt; sysbus_create_simple() is a condensed helper, but only allow you<br>
&gt; to pass qemu_irq objects, not a &#39;chardev&#39; property. So for thi=
s<br>
&gt; case you have to use the qdev API instead.<br>
<br>
Yes.=C2=A0 It&#39;s a helper that combines creating a sysbus device, wiring=
 up<br>
one MMIO region and one IRQ, and realizing.=C2=A0 If you need to configure =
or<br>
wire up more than that, you can&#39;t use it.<br>
<br>
&gt;&gt; How do I know<br>
&gt;&gt; which method to use while creating an object?<br>
&gt;<br>
&gt; SysBusDevice are plugged onto a bus. QDev aren&#39;t.<br>
&gt; The sysbus API results in smaller code, easier to review.<br>
<br>
The general pattern for a stand-alone device is<br>
<br>
=C2=A0 =C2=A0 dev =3D qdev_new(type_name);<br>
=C2=A0 =C2=A0 set properties and wire up stuff...<br>
=C2=A0 =C2=A0 qdev_realize_and_unref(dev, bus, &amp;err);<br>
<br>
When this is to be done in device code, say to create a component<br>
device, the split between .instance_init() and .realize() complicates<br>
things.=C2=A0 If interested, ask and I&#39;ll explain.<br>
<br>
There are quite a few wrappers around qdev_ functions for various<br>
subtypes of TYPE_DEVICE.=C2=A0 Use them to make your code more concise and<=
br>
easier to understand.=C2=A0 Example: sysbus_realize_and_unref().<br>
<br>
There are also convenience functions that capture special cases of the<br>
entire general pattern.=C2=A0 Example: sysbus_create_simple().<br>
<br>
Hope this helps!<br>
<br>
</blockquote></div>

--000000000000e823d605aa7b5143--

