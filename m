Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191C9C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D3320B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D3320B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48636 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZD2c-0007iH-R4
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36935)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hZC3P-0002jM-Co
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hZC3M-0000pa-9x
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:24:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hZC3I-0000ji-PD; Fri, 07 Jun 2019 06:24:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4873B22386B;
 Fri,  7 Jun 2019 10:24:51 +0000 (UTC)
Received: from redhat.com (ovpn-112-33.ams2.redhat.com [10.36.112.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34EAD7F481;
 Fri,  7 Jun 2019 10:24:45 +0000 (UTC)
Date: Fri, 7 Jun 2019 11:24:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190607102442.GD28838@redhat.com>
References: <20190605213654.9785-1-ptoscano@redhat.com>
 <20190606111232.GG14300@redhat.com>
 <3631777.4JPVOlAZr6@lindworm.usersys.redhat.com>
 <20190607100810.GB28838@redhat.com>
 <a42dbdce-3e03-d27c-7d28-f15d668848ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a42dbdce-3e03-d27c-7d28-f15d668848ae@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 07 Jun 2019 10:24:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6] ssh: switch from libssh2 to libssh
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 rjones@redhat.com, mreitz@redhat.com, Pino Toscano <ptoscano@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 12:14:37PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 6/7/19 12:08 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Jun 06, 2019 at 07:51:15PM +0200, Pino Toscano wrote:
> >> On Thursday, 6 June 2019 13:12:32 CEST Daniel P. Berrang=C3=A9 wrote=
:
> >>> On Wed, Jun 05, 2019 at 11:36:54PM +0200, Pino Toscano wrote:
> >>>> Rewrite the implementation of the ssh block driver to use libssh i=
nstead
> >>>> of libssh2.  The libssh library has various advantages over libssh=
2:
> >>>> - easier API for authentication (for example for using ssh-agent)
> >>>> - easier API for known_hosts handling
> >>>> - supports newer types of keys in known_hosts
> >>>>
> >>>> Use APIs/features available in libssh 0.8 conditionally, to suppor=
t
> >>>> older versions (which are not recommended though).
> >>>
> >>>
> >>>>
> >>>> Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> >>>> ---
> >>>>
> >>>> Changes from v5:
> >>>> - adapt to newer tracing APIs
> >>>> - disable ssh compression (mimic what libssh2 does by default)
> >>>> - use build time checks for libssh 0.8, and use newer APIs directl=
y
> >>>>
> >>>> Changes from v4:
> >>>> - fix wrong usages of error_setg/session_error_setg/sftp_error_set=
g
> >>>> - fix few return code checks
> >>>> - remove now-unused parameters in few internal functions
> >>>> - allow authentication with "none" method
> >>>> - switch to unsigned int for the port number
> >>>> - enable TCP_NODELAY on the socket
> >>>> - fix one reference error message in iotest 207
> >>>>
> >>>> Changes from v3:
> >>>> - fix socket cleanup in connect_to_ssh()
> >>>> - add comments about the socket cleanup
> >>>> - improve the error reporting (closer to what was with libssh2)
> >>>> - improve EOF detection on sftp_read()
> >>>>
> >>>> Changes from v2:
> >>>> - used again an own fd
> >>>> - fixed co_yield() implementation
> >>>>
> >>>> Changes from v1:
> >>>> - fixed jumbo packets writing
> >>>> - fixed missing 'err' assignment
> >>>> - fixed commit message
> >>>>
> >>>>  block/Makefile.objs        |   6 +-
> >>>>  block/ssh.c                | 610 +++++++++++++++++++-------------=
-----
> >>>>  block/trace-events         |  14 +-
> >>>>  configure                  |  62 ++--
> >>>>  tests/qemu-iotests/207.out |   2 +-
> >>>>  5 files changed, 351 insertions(+), 343 deletions(-)
> >>>
> >>>
> >>>> diff --git a/configure b/configure
> >>>> index b091b82cb3..bfdd70c40a 100755
> >>>> --- a/configure
> >>>> +++ b/configure
> >>>
> >>>> @@ -3914,43 +3914,17 @@ EOF
> >>>>  fi
> >>>> =20
> >>>>  ##########################################
> >>>> -# libssh2 probe
> >>>> -min_libssh2_version=3D1.2.8
> >>>
> >>> The commit message says we're conditionally using APIs from 0.8.0,
> >>> but doesn't say what minimum version we actually need and there's
> >>> no check here.
> >>
> >> When I started to work on this, the libssh version available was
> >> 0.6.x IIRC, which is very old.  This v6 uses APIs added in 0.8
> >> conditionally, so it will still build with libssh < 0.8 -- of course=
,
> >> using an older libssh results in a less performant ssh driver, altho=
ugh
> >> I would think this can be considered somehow acceptable.
> >>
> >>> In terms of our supported build platforms, the oldest libssh I
> >>> see is RHEL-7 with 0.7.1.
> >>>
> >>> So assume it does actually compile on RHEL-7, then it is desirable
> >>> to have a min_libssh_Version=3D0.7.1 set here & checked below.
> >>
> >> For now I do not see the need to enforce a minimum version required;
> >> it can be easily added in the future in case we need to use an API o=
nly
> >> available starting from some version, and there is no fallback way f=
or
> >> older versions.
> >=20
> > In general we aim to set a clear minimum version for all our third
> > party deps based on our platform support policy. We don't want to
> > keep backcompat code around forever even if it is posisble to add
> > fallback with #ifdefs. So even if we might still work with 0.6.x,
> > we should declare 0.7.1 our min version IMHO.
>=20
> With our CI setup we use:
>=20
> Trusty (Ubuntu 14.04.5 LTS)
> Source: libssh
> Version: 0.6.1-0ubuntu3
> Replaces: libssh-2-dev
>=20
> Xenial
> Source: libssh
> Version: 0.6.3-4.3
> Replaces: libssh-2-dev
>=20
> The distrib packages do not allow dual use.

I missed that Ubuntu, unusually, had older versions than RHEL.

We don't use Trusty though - our Travis config requests Xenial
these days. So 0.6.3 is sufficient as a min version

> > Incidentally that reminds me that it is desirable to modify the
> > various native arch tests/docker/dockerfiles/*docker files to
> > list libssh as a package to install so that we get compile testing
> > coverage.
>=20
> I'm testing Pino patch and already did that :)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

