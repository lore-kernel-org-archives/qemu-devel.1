Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50987C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7EE2464B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnb2x1vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7EE2464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBfa0-0000Kn-Uo
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 10:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBfZG-0008Je-4f
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBfZD-0005nn-L0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:09:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23171
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBfZD-0005hq-Bp
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583849346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3W5+lOfNxc3URcEsJ5BD/Bc835ZffN71N6MH46Qwxc=;
 b=hnb2x1vg+Qu5YazCbDDgyB1jtDZh8H44MUZgBl+GA2v30nLuQi7uzzQF0zAcG0lyHi2pGT
 WduykoB5o45Z6858altAU+hxG0bblgn82ALdJ/6dLIa/xFShpdONkqZ2mEXSCP7DO1iSv7
 2DK6diHnIa0I852C4Ar2W0/9o4XExeo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-Mm2csp5aPtWs5NWDv8rV0g-1; Tue, 10 Mar 2020 10:09:04 -0400
X-MC-Unique: Mm2csp5aPtWs5NWDv8rV0g-1
Received: by mail-qv1-f72.google.com with SMTP id v19so3057039qvk.9
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 07:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iVh+G5uJLKgCl1Fc47D8hraF0D/imlAzWwyvokngQIY=;
 b=mH84LUg8sb/TaI6HleuKLN49+mJogUY9eyOmwKZ2mZUR8zn8JwNGHiyjJ82CwvNlxC
 wjMiYzgEN6SZIQG5ATHiC1Hh1AsNDd6UKA+/IP3wLAi1DFTGaEDbz4gQOzB35JvonMW9
 C/esurfDdVpZgLHVekRdHAzVpfbS6UH0jxIRG9+4GyVOkmciI19GgLTfQXvpOE/H9log
 OJfCkEwLh5J/Er7q7TRPxwTOMTYcuN+oj1z9fBI8U5Ov6gdSSW1kwt6Z9TxMSaDgGe2d
 ugvx+hIzLhU6TkrVB8f3xgfcD7+3nzPA9Mi78yfAaDbgUTn/uZdPRbIM++WAeKlck9lB
 wwCA==
X-Gm-Message-State: ANhLgQ1QeU/uMTfnth65qjQtmeuCcy0csqO6iVq2g7zp7hynU6w69jZ+
 Kki1PT3/ay+xhjhQuTSUN7tfzZSe1PTMcEYHHmX2XCPCt6+CDxqppcdHHwiWucj6E3pFpEcUaZm
 EhICBKWOV5MvuUVU=
X-Received: by 2002:a37:4c0a:: with SMTP id z10mr6664434qka.408.1583849343443; 
 Tue, 10 Mar 2020 07:09:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvsBKkjeb0G03ioaBO9vnOPEA5mTrU8HRBDiGomjmkvkfbjSjyu4vvlTrKtuKHpQMoZkJh18A==
X-Received: by 2002:a37:4c0a:: with SMTP id z10mr6664374qka.408.1583849342885; 
 Tue, 10 Mar 2020 07:09:02 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id g15sm20431690qtq.71.2020.03.10.07.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 07:09:01 -0700 (PDT)
Date: Tue, 10 Mar 2020 10:08:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
Message-ID: <20200310094350-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-6-liran.alon@oracle.com>
 <20200310081144-mutt-send-email-mst@kernel.org>
 <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
 <20200310082730-mutt-send-email-mst@kernel.org>
 <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
 <20200310084758-mutt-send-email-mst@kernel.org>
 <1f4766b2-9683-8ebf-752e-a0378bb0cbc3@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1f4766b2-9683-8ebf-752e-a0378bb0cbc3@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 03:35:25PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 14:53, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 02:43:51PM +0200, Liran Alon wrote:
> > > On 10/03/2020 14:35, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 10, 2020 at 02:25:28PM +0200, Liran Alon wrote:
> > > > > On 10/03/2020 14:14, Michael S. Tsirkin wrote:
> > > > > > On Tue, Mar 10, 2020 at 01:54:02AM +0200, Liran Alon wrote:
> > > > > > > As can be seen from VmCheck_GetVersion() in open-vm-tools cod=
e,
> > > > > > > CMD_GETVERSION should return VMX type in ECX register.
> > > > > > >=20
> > > > > > > Default is to fake host as VMware ESX server. But user can co=
ntrol
> > > > > > > this value by "-global vmport.vmx-type=3DX".
> > > > > > >=20
> > > > > > > Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> > > > > > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > > > > > ---
> > > > > > >     hw/i386/vmport.c | 13 +++++++++++++
> > > > > > >     1 file changed, 13 insertions(+)
> > > > > > >=20
> > > > > > > diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> > > > > > > index a2c8ff4b59cf..c03f57f2f636 100644
> > > > > > > --- a/hw/i386/vmport.c
> > > > > > > +++ b/hw/i386/vmport.c
> > > > > > > @@ -36,6 +36,15 @@
> > > > > > >     #define VMPORT_ENTRIES 0x2c
> > > > > > >     #define VMPORT_MAGIC   0x564D5868
> > > > > > > +typedef enum {
> > > > > > > +   VMX_TYPE_UNSET =3D 0,
> > > > > > > +   VMX_TYPE_EXPRESS,    /* Deprecated type used for VMware E=
xpress */
> > > > > > > +   VMX_TYPE_SCALABLE_SERVER,    /* VMware ESX server */
> > > > > > > +   VMX_TYPE_WGS,        /* Deprecated type used for VMware S=
erver */
> > > > > > > +   VMX_TYPE_WORKSTATION,
> > > > > > > +   VMX_TYPE_WORKSTATION_ENTERPRISE /* Deprecated type used f=
or ACE 1.x */
> > > > > > > +} VMX_Type;
> > > > > > > +
> > > > > > Is this really VMX type? And do users care what it is?
> > > > > This enum is copied from open-vm-tools source code
> > > > > (lib/include/vm_version.h). This is how it's called in VMware Too=
ls
> > > > > terminology... Don't blame me :)
> > > > I don't even want to go look at it to check license compatibility, =
but
> > > > IMHO that's just another reason to avoid copying it.
> > > > Copying bad code isn't a good idea unless needed for
> > > > compatibility.
> > > Preserving original VMware terminology makes sense and is preferred i=
n my
> > > opinion. I think diverging from it is more confusing.
> > Yea tell it to people who got in hot water because they copied
> > some variable names to avoid confusion. Oh wait.
> >=20
> > This is not an official terminology I think.
> Maybe it wasn't clear from my previous messages, but open-vm-tools is an
> official VMware open-source project...
> VMX is the official name of the VMware Userspace-VMM and VMX-Type is an
> official name as-well.
>=20
> I'm also not copying code here... I'm copying definitions from relevant
> header files to implement a compatible interface.

You don't need to have enum have same names to be compatible.
And in this case, all we really need is just a single number *2*
and a comment saying that's ESX server.

> This is no different than copying constants from a Linux device driver to
> implement it's device emulation in QEMU.

We really try to avoid stuff like this. If one does this one has to
check license etc etc.  But in this case, the names are confusing,
violate our coding style, I could go on.


> > So please just make it make sense by itself, and make it
> > easy to research.
> I think I have made it the most easiest to research. Having exactly same
> names as VMware official project and pointing to it directly from comment=
s
> and commit messages.

What good does this do when that code will change tomorrow?

You worry about code being easy to write, I worry about it
being easy to read.

Here are things we can do to make things easier for users and readers:
- use full name VM executable instead of VMX
- put in official product names in comments instead of enums
- write code using our coding style
- add a link to where you found a specific number in comments






> >=20
> > > >=20
> > > > > > Also, how about friendlier string values so people don't need t=
o
> > > > > > figure out code numbers?
> > > > > I could have defined a new PropertyInfo struct in hw/core/qdev-pr=
operties.c
> > > > > for this enum and then define a proper macro in qdev-properties.h=
.
> > > > > But it seems like an overkill for a value that is suppose to rare=
ly be
> > > > > changed. So I thought this should suffice for now for user-experi=
ence
> > > > > perspective.
> > > > > If you think otherwise, I can do what I just suggested above.
> > > > >=20
> > > > > -Liran
> > > > I think that's better, and this allows you to use official
> > > > product names that people can relate to.
> > > Ok. Will do...
> > > > Alternatively just drop this enum completely.  As far as you are
> > > > concerned it's just a number VM executable gives together with the
> > > > version, right?  We don't even need the enum, just set it to 2 and =
add a
> > > > code comment saying it's esx server.
> > > I could do the latter alternative but why? It just hides information
> > > original patch author (myself) know about where this value comes from=
.
> > > I don't see a reason to hide information from future code maintainers=
.
> > > Similar to defining all flags of a given flag-field even if we use on=
ly a
> > > subset of it.
> > >=20
> > > -Liran
> > That belongs in a code comment. Removes need to follow silly names from
> > unrelated and possibly incompatible license.
>=20
> What do you mean "unrelated"? It's an official VMware open-source project
> for VMware Tools...
> I'm only copying definition of constants...

No you also copy names and comments. Which might make sense in the
context of the original project but seem to make no sense here.
E.g. for vmware a given product is deprecated but why does QEMU care?
enum values are not even listed. What is poor user supposed to do -
take out a calculator to figure it out?

> > By comparison dead code is
> > dead code.
> Right. That's why I think the enum PropertyInfo mechanism is an overkill =
at
> this point.
> > But sure, if you want to code up user friendly names, that's
> > ok too. But do follow official names then please, not something lifted
> > from some piece of code.
>=20
> These are all official names.

Official as in will stick around, not official as in pushed to
a github repo.


> I'm not sure I understand what you are
> suggesting.
>=20
> -Liran

Something like the below.

/*
 * Most guests are fine with the default.
 * Some legacy guests hard-code a given type.
 * See https://github.com/vmware/open-vm-tools/blob/master/open-vm-tools/li=
b/include/vm_vmx_type.h
 * for an up-to-date list of values.
 *
 * Reasonable options:
 * 0 - unset?
 * 1 - VMware Express (deprecated)
 * 2 - VMware ESX server
 * 3 - VMware Workstation
 * 4 - ACE 1.x (deprecated)
 */

DEFINE_PROP_UINT8("vm-executable-type", VMPortState, vm_executable_type, 2 =
/* VMware ESX server */),




