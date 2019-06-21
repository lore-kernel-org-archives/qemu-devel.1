Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B0C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 07:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72052206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 07:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72052206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55282 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heDok-0001BQ-B8
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 03:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35686)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fziglio@redhat.com>) id 1heDna-0000io-Rt
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fziglio@redhat.com>) id 1heDnU-0005p6-P5
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:17:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46674)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1heDnU-0005Mc-CZ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:17:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB9726EB8A;
 Fri, 21 Jun 2019 07:16:52 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DBE060BEC;
 Fri, 21 Jun 2019 07:16:52 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 995E924F19;
 Fri, 21 Jun 2019 07:16:50 +0000 (UTC)
Date: Fri, 21 Jun 2019 03:16:48 -0400 (EDT)
From: Frediano Ziglio <fziglio@redhat.com>
To: Kevin Pouget <kpouget@redhat.com>
Message-ID: <2139720774.23871724.1561101408712.JavaMail.zimbra@redhat.com>
In-Reply-To: <CADJ1XR3fh0cyOerSM8VQkpde6cHLb8WccP05Rwr7xWMOK59rog@mail.gmail.com>
References: <20190619123042.4822-1-kpouget@redhat.com>
 <e9fcdbfd-cde2-fc91-ce1d-6bfe06d39c4f@redhat.com>
 <CADJ1XR3fh0cyOerSM8VQkpde6cHLb8WccP05Rwr7xWMOK59rog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.33.32.12, 10.4.195.28]
Thread-Topic: spice-core: allow setting properties from QMP
Thread-Index: JcZm5h4xS1Mxjqqfp/uZaSyKbIHTxQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 21 Jun 2019 07:16:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] spice-core: allow setting properties from QMP
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
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> 
> Hello Eric,
> 
> > A new command may be okay, however,
> 
> thanks, I've fix the typos and updated the patch to use an Enum, which
> indeed makes more sense.
> 
> I've also updated "spice-query" command to provide the current value
> of the "video-codec" property,
> but it made me wonder if I should improve this QMP interface with a
> json list, or keep the current string-based list
> ("enc1:codec1;enc2:codec2").
> 
> I CC the spice-devel list to get their point of view
> 
> The current behavior is:
> 
> --> { "execute": "set-spice", "arguments": { "property":
> "video-codecs", "value": "spice:mjpeg;gstreamer:h264" } }
> <-- {"return":{},"id":"libvirt-23"}

It looks complicated from the user. Why not just

--> { "execute": "set-spice", "arguments": { "video-codecs": "spice:mjpeg;gstreamer:h264" } }

> 
> --> { "execute": "query-spice" }
> <-- {.... "video-codecs": "spice:mjpeg;gstreamer:h264;" ....}
> 
> 
> I put the new version of the RFC patch below
> 
> best regards,
> 
> Kevin
> 
> ---
> 
> This patch allows setting spice properties from the QMP interface.
> 
> At the moment, only the 'video-codecs' property is supported.
> 
> Signed-off-by: Kevin Pouget <kpouget@redhat.com>
> ---
>  qapi/ui.json    | 42 ++++++++++++++++++++++++++++++++++++++++--
>  ui/spice-core.c | 21 +++++++++++++++++++++
>  2 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 59e412139a..5f67096bcb 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -211,12 +211,16 @@
>  #
>  # @channels: a list of @SpiceChannel for each active spice channel
>  #
> +# @video-codecs: The list of encoders:codecs currently allowed for
> +#                video streaming (since: ...)
> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'SpiceInfo',
>    'data': {'enabled': 'bool', 'migrated': 'bool', '*host': 'str',
> '*port': 'int',
>             '*tls-port': 'int', '*auth': 'str', '*compiled-version': 'str',
> -           'mouse-mode': 'SpiceQueryMouseMode', '*channels':
> ['SpiceChannel']},
> +           'mouse-mode': 'SpiceQueryMouseMode', '*channels':
> ['SpiceChannel'],
> +           'video-codecs': 'str'},
>    'if': 'defined(CONFIG_SPICE)' }
> 
>  ##
> @@ -257,7 +261,8 @@
>  #                "tls": false
>  #             },
>  #             [ ... more channels follow ... ]
> -#          ]
> +#          ],
> +#          "video-codecs": "spice:mjpeg;gstreamer:h264;"
>  #       }
>  #    }
>  #
> @@ -265,6 +270,39 @@
>  { 'command': 'query-spice', 'returns': 'SpiceInfo',
>    'if': 'defined(CONFIG_SPICE)' }
> 
> +##
> +# @SpiceProperty:
> +#
> +# An enumeration of Spice properties that can be set at runtime.
> +#
> +# @video-codecs: the ;-separated list of video-codecs allowed for
> +# spice-server video streaming.
> +#
> +# Since: ...
> +##
> +{ 'enum': 'SpiceProperty',
> +  'data': [ 'video-codecs'],
> +  'if': 'defined(CONFIG_SPICE)' }
> +
> +##
> +# @set-spice:
> +#
> +# Set Spice properties.
> +# @property: the SPICE property to modify
> +# @value: the new value to affect to this property
> +#
> +# Since: ...
> +#
> +# Example:
> +#
> +# -> { "execute": "set-spice", "arguments": { "property": "video-codecs",
> +#                                             "value": "spice:mjpeg;" } }
> +# <- { "returns": {} }
> +##
> +{ 'command': 'set-spice',
> +  'data': {'property': 'SpiceProperty', 'value': 'str'},
> +  'if': 'defined(CONFIG_SPICE)' }
> +
>  ##
>  # @SPICE_CONNECTED:
>  #
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 63e8694df8..1660f49f15 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -506,6 +506,25 @@ static QemuOptsList qemu_spice_opts = {
>      },
>  };
> 
> +void qmp_set_spice(SpiceProperty property, const char *value, Error **errp)
> +{
> +    int invalid_codecs;
> +
> +    switch(property) {
> +    case SPICE_PROPERTY_VIDEO_CODECS:
> +        invalid_codecs = spice_server_set_video_codecs(spice_server, value);
> +
> +        if (invalid_codecs) {
> +            error_setg(errp, "Found %d invalid video-codecs while
> setting spice"
> +                       " property 'video-codec=%s'", invalid_codecs, value);
> +        }
> +        break;
> +    default:
> +        /* only reached in case of version mismatched */
> +        error_setg(errp, "Property #%d not supported.", property);
> +    }
> +}
> +
>  SpiceInfo *qmp_query_spice(Error **errp)
>  {
>      QemuOpts *opts = QTAILQ_FIRST(&qemu_spice_opts.head);
> @@ -555,6 +574,8 @@ SpiceInfo *qmp_query_spice(Error **errp)
>                         SPICE_QUERY_MOUSE_MODE_SERVER :
>                         SPICE_QUERY_MOUSE_MODE_CLIENT;
> 
> +    info->video_codecs = spice_server_get_video_codecs(spice_server);
> +
>      /* for compatibility with the original command */
>      info->has_channels = true;
>      info->channels = qmp_query_spice_channels();
> --
> 2.21.0
> 
> 

