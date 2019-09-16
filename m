Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B41C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 12:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A68214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 12:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A68214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9pvf-0000My-FS
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 08:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i9puY-0008Ly-6P
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i9puS-00046P-3y
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:15:17 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39947)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i9puP-000457-CG
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:15:10 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MUGqT-1hiVrb3ylf-00REUd; Mon, 16 Sep 2019 14:15:01 +0200
To: qemu-devel@nongnu.org
References: <20190906083812.29487-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9af840fe-4f9e-1ff8-9bc8-11e9824a841d@vivier.eu>
Date: Mon, 16 Sep 2019 14:14:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906083812.29487-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sKIdCnQiHH6tsaJXMn1zaWeFOZ/vQtf6QT51djdc6CpJyTVhF4P
 H/TUIXEHx3fwBwWan0C5UQQX+V2sL5W0iXTDYhMzHUrfgGMHJUjVybih+uJckwJu6qigy+s
 yMH3H2mBqR3SVFp4hdHihhK8LSyBmnApk50TIrCRjLAlUQConLIO0rxpTk/YLTdH7qGdRHs
 t+i7uNfR4Ywb8y1WgJOww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fb2Svzn2l4c=:Aq1WtOFJrV3Ef/3+P0xTWG
 GcsVf50oHrcGV4N76CJRUCLpw+29fZAN+U50Fzg1QIL04nVgv7LShnSvbirvlGbH3SQjXK8eH
 kc6L1B/X8wT40joxFcF5usIJdfNIJXlgnXEt/EMnR8nv8KewkCf6mRCUkrnJttP5uTzK1lBy3
 28cSl9l3lWVJ4TDytR+t45RHstuDlxBv62Tw9bBV5T01+NLDnPMRK6GkDWqYxSltGlOtAFdcZ
 8q+5j6+RhuXYkO6fWClrycZ7+Na+QzwOIDKl0M96hn7XumkVHy0zcUEe19ld/U4m8NCTzE/50
 PF0IyipX0/NBzmF6kCjN1gHxJhBVopQx6Lt11Eo5tJDj8LCMbVUZt29Bg4MTZJVru+IGNUm9c
 EoG4gL/Sxh1ZaSmiH/HdoV149u6+Q5z9rS3WFpIAYCfOEJMHCgLasSmk5k0yOGTxTi7A/hhGx
 H7NUdalkDv9YBzElOxSkmIBsBxr+cdjvPflXN8QNqgsgk/5Wm+QcWxo8pz6uHaeFr6hakL/Wq
 qj8pHCXplao7+EfSIenqtS4anh5oogNoAOBzeZ7WJR5vLY8BGCF7GAHjcVmQWLZoVSvzpTKjs
 0rMrnSu6a3Q0lcLegWOIlCESpU8KVIrESbvfEy+PELMpNx/gAYt3NCFRNWJZBxv+pkMM5NGUW
 vvDKSIPpnRkYOJQwOcgesMLvUrP9VCQ1k2fHf43guE7GIbIqYE7oGnMMlsXETvh8oa8Yx1IFM
 oVidsc95LPtLab8mwKiO7ES+yp778dq9nPVKaqAIU4/kgaHyPtEfYyBQ4HEBg+I4lHiTmIluZ
 k20TrjNZJ9HNODyzvnIUkRqdjH9jemgNkExeRebMn+3R01SKhzZMk4+Gqbn7GVFRoJsnaZFCJ
 y/NADzLwBsiOMoJ0T5fGS/ax1+0LW5uvpCK1eYkXI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH v3] ui: add an embedded Barrier client
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Ping?


Le 06/09/2019 à 10:38, Laurent Vivier a écrit :
> This allows to receive mouse and keyboard events from
> a Barrier server.
> 
> This is enabled by adding the following parameter on the
> command line
> 
>     ... -object input-barrier,id=$id,name=$name ...
> 
> Where $name is the name declared in the screens section of barrier.conf
> 
> The barrier server (barriers) must be configured and must run on the
> local host.
> 
> For instance:
> 
>   section: screens
>       localhost:
>           ...
>       VM-1:
>           ...
>       end
> 
>   section: links
>       localhost:
>           right = VM-1
>       VM-1:
>           left = localhost
>   end
> 
> Then on the QEMU command line:
> 
>     ... -object input-barrier,id=barrie0,name=VM-1 ...
> 
> When the mouse will move out of the screen of the local host on
> the right, the mouse and the keyboard will be grabbed and all
> related events will be send to the guest OS.
> 
> This is usefull when qemu is configured without emulated graphic card
> but with a VFIO attached graphic card.
> 
> More information about Barrier can be found at:
> 
>   https://github.com/debauchee/barrier
> 
> This avoids to install the Barrier server in the guest OS,
> for instance when it is not supported or during the installation.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v3: remove typo in barrier.txt
>     
>     v2: use qemu_input_map_xorgkbd_to_qcode[] to convert button field
>         use keyboard_layout to convert keys if button field is not available
>         fix some command in the protocol
>         add ui/input-barrier.h
>         rework read/write functions
>         add server/port properties
>         add display properties
>         rework protocol
>         allow to reconnect (object_del + object_add)
>         add documentation
> 
>  docs/barrier.txt   | 370 ++++++++++++++++++++++
>  ui/Makefile.objs   |   1 +
>  ui/input-barrier.c | 750 +++++++++++++++++++++++++++++++++++++++++++++
>  ui/input-barrier.h | 112 +++++++
>  4 files changed, 1233 insertions(+)
>  create mode 100644 docs/barrier.txt
>  create mode 100644 ui/input-barrier.c
>  create mode 100644 ui/input-barrier.h
> 
> diff --git a/docs/barrier.txt b/docs/barrier.txt
> new file mode 100644
> index 000000000000..b21d15015d96
> --- /dev/null
> +++ b/docs/barrier.txt
> @@ -0,0 +1,370 @@
> +                                QEMU Barrier Client
> +
> +
> +* About
> +
> +    Barrier is a KVM (Keyboard-Video-Mouse) software forked from Symless's
> +    synergy 1.9 codebase.
> +
> +    See https://github.com/debauchee/barrier
> +
> +* QEMU usage
> +
> +    Generally, mouse and keyboard are grabbed through the QEMU video
> +    interface emulation.
> +
> +    But when we want to use a video graphic adapter via a PCI passthrough
> +    there is no way to provide the keyboard and mouse inputs to the VM
> +    except by plugging a second set of mouse and keyboard to the host
> +    or by installing a KVM software in the guest OS.
> +
> +    The QEMU Barrier client avoids this by implementing directly the Barrier
> +    protocol into QEMU.
> +
> +    This protocol is enabled by adding an input-barrier object to QEMU.
> +
> +    Syntax: input-barrier,id=<object-id>,name=<guest display name>
> +            [,server=<barrier server address>][,port=<barrier server port>]
> +            [,x-origin=<x-origin>][,y-origin=<y-origin>]
> +            [,width=<width>][,height=<height>]
> +
> +    The object can be added on the QEMU command line, for instance with:
> +
> +        ... -object input-barrier,id=barrier0,name=VM-1 ...
> +
> +    where VM-1 is the name the display configured int the Barrier server
> +    on the host providing the mouse and the keyboard events.
> +
> +    by default <barrier server address> is "localhost", port is 24800,
> +    <x-origin> and <y-origin> are set to 0, <width> and <height> to
> +    1920 and 1080.
> +
> +    If Barrier server is stopped QEMU needs to be reconnected manually,
> +    by removing and re-adding the input-barrier object, for instance
> +    with the help of the HMP monitor:
> +
> +        (qemu) object_del barrier0
> +        (qemu) object_add input-barrier,id=barrier0,name=VM-1
> +
> +* Message format
> +
> +    Message format between the server and client is in two parts:
> +
> +        1- the payload length is a 32bit integer in network endianness,
> +        2- the payload
> +
> +    The payload starts with a 4byte string (without NUL) which is the
> +    command. The first command between the server and the client
> +    is the only command not encoded on 4 bytes ("Barrier").
> +    The remaining part of the payload is decoded according to the command.
> +
> +* Protocol Description (from barrier/src/lib/barrier/protocol_types.h)
> +
> +    - barrierCmdHello          "Barrier"
> +
> +      Direction:  server -> client
> +      Parameters: { int16_t minor, int16_t major }
> +      Description:
> +
> +          Say hello to client
> +          minor = protocol major version number supported by server
> +          major = protocol minor version number supported by server
> +
> +    - barrierCmdHelloBack      "Barrier"
> +
> +      Direction:  client ->server
> +      Parameters: { int16_t minor, int16_t major, char *name}
> +      Description:
> +
> +          Respond to hello from server
> +          minor = protocol major version number supported by client
> +          major = protocol minor version number supported by client
> +          name  = client name
> +
> +    - barrierCmdDInfo          "DINF"
> +
> +      Direction:  client ->server
> +      Parameters: { int16_t x_origin, int16_t y_origin, int16_t width, int16_t height, int16_t x, int16_t y}
> +      Description:
> +
> +          The client screen must send this message in response to the
> +          barrierCmdQInfo message.  It must also send this message when the
> +          screen's resolution changes.  In this case, the client screen should
> +          ignore any barrierCmdDMouseMove messages until it receives a
> +          barrierCmdCInfoAck in order to prevent attempts to move the mouse off
> +          the new screen area.
> +
> +    - barrierCmdCNoop          "CNOP"
> +
> +      Direction:  client -> server
> +      Parameters: None
> +      Description:
> +
> +          No operation
> +
> +    - barrierCmdCClose         "CBYE"
> +
> +      Direction:  server -> client
> +      Parameters: None
> +      Description:
> +
> +          Close connection
> +
> +    - barrierCmdCEnter         "CINN"
> +
> +      Direction:  server -> client
> +      Parameters: { int16_t x, int16_t y, int32_t seq, int16_t modifier }
> +      Description:
> +
> +          Enter screen.
> +          x,y      = entering screen absolute coordinates
> +          seq      = sequence number, which is used to order messages between
> +                     screens.  the secondary screen must return this number
> +                     with some messages
> +          modifier = modifier key mask.  this will have bits set for each
> +                     toggle modifier key that is activated on entry to the
> +                     screen.  the secondary screen should adjust its toggle
> +                     modifiers to reflect that state.
> +
> +    - barrierCmdCLeave         "COUT"
> +
> +      Direction:  server -> client
> +      Parameters: None
> +      Description:
> +
> +          Leaving screen.  the secondary screen should send clipboard data in
> +          response to this message for those clipboards that it has grabbed
> +          (i.e. has sent a barrierCmdCClipboard for and has not received a
> +          barrierCmdCClipboard for with a greater sequence number) and that
> +          were grabbed or have changed since the last leave.
> +
> +    - barrierCmdCClipboard     "CCLP"
> +
> +      Direction:  server -> client
> +      Parameters: { int8_t id, int32_t seq }
> +      Description:
> +
> +          Grab clipboard. Sent by screen when some other app on that screen
> +          grabs a clipboard.
> +          id  = the clipboard identifier
> +          seq = sequence number. Client must use the sequence number passed in
> +                the most recent barrierCmdCEnter.  the server always sends 0.
> +
> +    - barrierCmdCScreenSaver   "CSEC"
> +
> +      Direction:  server -> client
> +      Parameters: { int8_t started }
> +      Description:
> +
> +          Screensaver change.
> +          started = Screensaver on primary has started (1) or closed (0)
> +
> +    - barrierCmdCResetOptions  "CROP"
> +
> +      Direction:  server -> client
> +      Parameters: None
> +      Description:
> +
> +          Reset options. Client should reset all of its options to their
> +          defaults.
> +
> +    - barrierCmdCInfoAck       "CIAK"
> +
> +      Direction:  server -> client
> +      Parameters: None
> +      Description:
> +
> +          Resolution change acknowledgment. Sent by server in response to a
> +          client screen's barrierCmdDInfo. This is sent for every
> +          barrierCmdDInfo, whether or not the server had sent a barrierCmdQInfo.
> +
> +    - barrierCmdCKeepAlive     "CALV"
> +
> +      Direction:  server -> client
> +      Parameters: None
> +      Description:
> +
> +          Keep connection alive. Sent by the server periodically to verify
> +          that connections are still up and running.  clients must reply in
> +          kind on receipt.  if the server gets an error sending the message or
> +          does not receive a reply within a reasonable time then the server
> +          disconnects the client.  if the client doesn't receive these (or any
> +          message) periodically then it should disconnect from the server.  the
> +          appropriate interval is defined by an option.
> +
> +    - barrierCmdDKeyDown       "DKDN"
> +
> +      Direction:  server -> client
> +      Parameters: { int16_t keyid, int16_t modifier [,int16_t button] }
> +      Description:
> +
> +          Key pressed.
> +          keyid    = X11 key id
> +          modified = modified mask
> +          button   = X11 Xkb keycode (optional)
> +
> +    - barrierCmdDKeyRepeat     "DKRP"
> +
> +      Direction:  server -> client
> +      Parameters: { int16_t keyid, int16_t modifier, int16_t repeat [,int16_t button] }
> +      Description:
> +
> +          Key auto-repeat.
> +          keyid    = X11 key id
> +          modified = modified mask
> +          repeat   = number of repeats
> +          button   = X11 Xkb keycode (optional)
> +
> +    - barrierCmdDKeyUp         "DKUP"
> +
> +      Direction:  server -> client
> +      Parameters: { int16_t keyid, int16_t modifier [,int16_t button] }
> +      Description:
> +
> +          Key released.
> +          keyid    = X11 key id
> +          modified = modified mask
> +          button   = X11 Xkb keycode (optional)
> +
> +    - barrierCmdDMouseDown     "DMDN"
> +
> +      Direction:  server -> client
> +      Parameters: { int8_t button }
> +      Description:
> +
> +          Mouse button pressed.
> +          button = button id
> +
> +    - barrierCmdDMouseUp       "DMUP"
> +
> +      Direction:  server -> client
> +      Parameters: { int8_t button }
> +      Description:
> +
> +          Mouse button release.
> +          button = button id
> +
> +    - barrierCmdDMouseMove     "DMMV"
> +
> +      Direction:  server -> client
> +      Parameters: { int16_t x, int16_t y }
> +      Description:
> +
> +          Absolute mouse moved.
> +          x,y = absolute screen coordinates
> +
> +    - barrierCmdDMouseRelMove  "DMRM"
> +
> +      Direction:  server -> client
> +      Parameters: { int16_t x, int16_t y }
> +      Description:
> +
> +          Relative mouse moved.
> +          x,y = r relative screen coordinates
> +
> +    - barrierCmdDMouseWheel    "DMWM"
> +
> +      Direction:  server -> client
> +      Parameters: { int16_t x , int16_t y } or { int16_t y }
> +      Description:
> +
> +          Mouse scroll. The delta should be +120 for one tick forward (away
> +          from the user) or right and -120 for one tick backward (toward the
> +          user) or left.
> +          x = x delta
> +          y = y delta
> +
> +    - barrierCmdDClipboard     "DCLP"
> +
> +      Direction:  server -> client
> +      Parameters: { int8_t id, int32_t seq, int8_t mark, char *data }
> +      Description:
> +
> +          Clipboard data.
> +          id  = clipboard id
> +          seq = sequence number. The sequence number is 0 when sent by the
> +                server.  Client screens should use the/ sequence number from
> +                the most recent barrierCmdCEnter.
> +
> +    - barrierCmdDSetOptions    "DSOP"
> +
> +      Direction:  server -> client
> +      Parameters: { int32 t nb, { int32_t id, int32_t val }[] }
> +      Description:
> +
> +          Set options. Client should set the given option/value pairs.
> +          nb  = numbers of { id, val } entries
> +          id  = option id
> +          val = option new value
> +
> +    - barrierCmdDFileTransfer  "DFTR"
> +
> +      Direction:  server -> client
> +      Parameters: { int8_t mark, char *content }
> +      Description:
> +
> +          Transfer file data.
> +          mark = 0 means the content followed is the file size
> +                 1 means the content followed is the chunk data
> +                 2 means the file transfer is finished
> +
> +    - barrierCmdDDragInfo      "DDRG" int16_t char *
> +
> +      Direction:  server -> client
> +      Parameters: { int16_t nb, char *content }
> +      Description:
> +
> +          Drag information.
> +          nb      = number of dragging objects
> +          content = object's directory
> +
> +    - barrierCmdQInfo          "QINF"
> +
> +      Direction:  server -> client
> +      Parameters: None
> +      Description:
> +
> +          Query screen info
> +          Client should reply with a barrierCmdDInfo
> +
> +    - barrierCmdEIncompatible  "EICV"
> +
> +      Direction:  server -> client
> +      Parameters: { int16_t nb, major *minor }
> +      Description:
> +
> +          Incompatible version.
> +          major = major version
> +          minor = minor version
> +
> +    - barrierCmdEBusy          "EBSY"
> +
> +      Direction:  server -> client
> +      Parameters: None
> +      Description:
> +
> +          Name provided when connecting is already in use.
> +
> +    - barrierCmdEUnknown       "EUNK"
> +
> +      Direction:  server -> client
> +      Parameters: None
> +      Description:
> +
> +          Unknown client. Name provided when connecting is not in primary's
> +           screen configuration map.
> +
> +    - barrierCmdEBad           "EBAD"
> +
> +      Direction:  server -> client
> +      Parameters: None
> +      Description:
> +
> +          Protocol violation. Server should disconnect after sending this
> +          message.
> +
> +* TO DO
> +
> +    - Enable SSL
> +    - Manage SetOptions/ResetOptions commands
> +
> diff --git a/ui/Makefile.objs b/ui/Makefile.objs
> index ba39080edb2b..e6da6ff047fd 100644
> --- a/ui/Makefile.objs
> +++ b/ui/Makefile.objs
> @@ -9,6 +9,7 @@ vnc-obj-y += vnc-jobs.o
>  
>  common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
>  common-obj-y += input.o input-keymap.o input-legacy.o kbd-state.o
> +common-obj-y += input-barrier.o
>  common-obj-$(CONFIG_LINUX) += input-linux.o
>  common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
>  common-obj-$(CONFIG_COCOA) += cocoa.o
> diff --git a/ui/input-barrier.c b/ui/input-barrier.c
> new file mode 100644
> index 000000000000..a2c961f285a4
> --- /dev/null
> +++ b/ui/input-barrier.c
> @@ -0,0 +1,750 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/sockets.h"
> +#include "qapi/error.h"
> +#include "qom/object_interfaces.h"
> +#include "io/channel-socket.h"
> +#include "ui/input.h"
> +#include "ui/vnc_keysym.h" /* use name2keysym from VNC as we use X11 values */
> +#include "qemu/cutils.h"
> +#include "qapi/qmp/qerror.h"
> +#include "input-barrier.h"
> +
> +#define TYPE_INPUT_BARRIER "input-barrier"
> +#define INPUT_BARRIER(obj) \
> +    OBJECT_CHECK(InputBarrier, (obj), TYPE_INPUT_BARRIER)
> +#define INPUT_BARRIER_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(InputBarrierClass, (obj), TYPE_INPUT_BARRIER)
> +#define INPUT_BARRIER_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(InputBarrierClass, (klass), TYPE_INPUT_BARRIER)
> +
> +typedef struct InputBarrier InputBarrier;
> +typedef struct InputBarrierClass InputBarrierClass;
> +
> +#define MAX_HELLO_LENGTH 1024
> +
> +struct InputBarrier {
> +    Object parent;
> +
> +    QIOChannelSocket *sioc;
> +    guint ioc_tag;
> +
> +    /* display properties */
> +    gchar *name;
> +    int16_t x_origin, y_origin;
> +    int16_t width, height;
> +
> +    /* keyboard/mouse server */
> +
> +    SocketAddress saddr;
> +
> +    char buffer[MAX_HELLO_LENGTH];
> +};
> +
> +struct InputBarrierClass {
> +    ObjectClass parent_class;
> +};
> +
> +static const char *cmd_names[] = {
> +    [barrierCmdCNoop]          = "CNOP",
> +    [barrierCmdCClose]         = "CBYE",
> +    [barrierCmdCEnter]         = "CINN",
> +    [barrierCmdCLeave]         = "COUT",
> +    [barrierCmdCClipboard]     = "CCLP",
> +    [barrierCmdCScreenSaver]   = "CSEC",
> +    [barrierCmdCResetOptions]  = "CROP",
> +    [barrierCmdCInfoAck]       = "CIAK",
> +    [barrierCmdCKeepAlive]     = "CALV",
> +    [barrierCmdDKeyDown]       = "DKDN",
> +    [barrierCmdDKeyRepeat]     = "DKRP",
> +    [barrierCmdDKeyUp]         = "DKUP",
> +    [barrierCmdDMouseDown]     = "DMDN",
> +    [barrierCmdDMouseUp]       = "DMUP",
> +    [barrierCmdDMouseMove]     = "DMMV",
> +    [barrierCmdDMouseRelMove]  = "DMRM",
> +    [barrierCmdDMouseWheel]    = "DMWM",
> +    [barrierCmdDClipboard]     = "DCLP",
> +    [barrierCmdDInfo]          = "DINF",
> +    [barrierCmdDSetOptions]    = "DSOP",
> +    [barrierCmdDFileTransfer]  = "DFTR",
> +    [barrierCmdDDragInfo]      = "DDRG",
> +    [barrierCmdQInfo]          = "QINF",
> +    [barrierCmdEIncompatible]  = "EICV",
> +    [barrierCmdEBusy]          = "EBSY",
> +    [barrierCmdEUnknown]       = "EUNK",
> +    [barrierCmdEBad]           = "EBAD",
> +    [barrierCmdHello]          = "Barrier",
> +    [barrierCmdHelloBack]      = "Barrier",
> +};
> +
> +static kbd_layout_t *kbd_layout;
> +
> +static int input_barrier_to_qcode(uint16_t keyid, uint16_t keycode)
> +{
> +    /* keycode is optional, if it is not provided use keyid */
> +    if (keycode && keycode <= qemu_input_map_xorgkbd_to_qcode_len) {
> +        return qemu_input_map_xorgkbd_to_qcode[keycode];
> +    }
> +
> +    if (keyid >= 0xE000 && keyid <= 0xEFFF) {
> +        keyid += 0x1000;
> +    }
> +
> +    /* keyid is the X11 key id */
> +    if (kbd_layout) {
> +        keycode = keysym2scancode(kbd_layout, keyid, NULL, false);
> +
> +        return qemu_input_key_number_to_qcode(keycode);
> +    }
> +
> +    return qemu_input_map_x11_to_qcode[keyid];
> +}
> +
> +static int input_barrier_to_mouse(uint8_t buttonid)
> +{
> +    switch (buttonid) {
> +    case barrierButtonLeft:
> +        return INPUT_BUTTON_LEFT;
> +    case barrierButtonMiddle:
> +        return INPUT_BUTTON_MIDDLE;
> +    case barrierButtonRight:
> +        return INPUT_BUTTON_RIGHT;
> +    case barrierButtonExtra0:
> +        return INPUT_BUTTON_SIDE;
> +    }
> +    return buttonid;
> +}
> +
> +#define read_char(x, p, l)           \
> +do {                                 \
> +    int size = sizeof(char);         \
> +    if (l < size) {                  \
> +        return G_SOURCE_REMOVE;      \
> +    }                                \
> +    x = *(char *)p;                  \
> +    p += size;                       \
> +    l -= size;                       \
> +} while (0)
> +
> +#define read_short(x, p, l)          \
> +do {                                 \
> +    int size = sizeof(short);        \
> +    if (l < size) {                  \
> +        return G_SOURCE_REMOVE;      \
> +    }                                \
> +    x = ntohs(*(short *)p);          \
> +    p += size;                       \
> +    l -= size;                       \
> +} while (0)
> +
> +#define write_short(p, x, l)         \
> +do {                                 \
> +    int size = sizeof(short);        \
> +    if (l < size) {                  \
> +        return G_SOURCE_REMOVE;      \
> +    }                                \
> +    *(short *)p = htons(x);          \
> +    p += size;                       \
> +    l -= size;                       \
> +} while (0)
> +
> +#define read_int(x, p, l)            \
> +do {                                 \
> +    int size = sizeof(int);          \
> +    if (l < size) {                  \
> +        return G_SOURCE_REMOVE;      \
> +    }                                \
> +    x = ntohl(*(int *)p);            \
> +    p += size;                       \
> +    l -= size;                       \
> +} while (0)
> +
> +#define write_int(p, x, l)           \
> +do {                                 \
> +    int size = sizeof(int);          \
> +    if (l < size) {                  \
> +        return G_SOURCE_REMOVE;      \
> +    }                                \
> +    *(int *)p = htonl(x);            \
> +    p += size;                       \
> +    l -= size;                       \
> +} while (0)
> +
> +#define write_cmd(p, c, l)           \
> +do {                                 \
> +    int size = strlen(cmd_names[c]); \
> +    if (l < size) {                  \
> +        return G_SOURCE_REMOVE;      \
> +    }                                \
> +    memcpy(p, cmd_names[c], size);   \
> +    p += size;                       \
> +    l -= size;                       \
> +} while (0)
> +
> +#define write_string(p, s, l)        \
> +do {                                 \
> +    int size = strlen(s);            \
> +    if (l < size + sizeof(int)) {    \
> +        return G_SOURCE_REMOVE;      \
> +    }                                \
> +    *(int *)p = htonl(size);         \
> +    p += sizeof(size);               \
> +    l -= sizeof(size);               \
> +    memcpy(p, s, size);              \
> +    p += size;                       \
> +    l -= size;                       \
> +} while (0)
> +
> +static gboolean readcmd(InputBarrier *ib, struct barrierMsg *msg)
> +{
> +    int ret, len, i;
> +    enum barrierCmd cmd;
> +    char *p;
> +
> +    ret = qio_channel_read(QIO_CHANNEL(ib->sioc), (char *)&len, sizeof(len),
> +                           NULL);
> +    if (ret < 0) {
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    len = ntohl(len);
> +    if (len > MAX_HELLO_LENGTH) {
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    ret = qio_channel_read(QIO_CHANNEL(ib->sioc), ib->buffer, len, NULL);
> +    if (ret < 0) {
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    p = ib->buffer;
> +    if (len >= strlen(cmd_names[barrierCmdHello]) &&
> +        memcmp(p, cmd_names[barrierCmdHello],
> +               strlen(cmd_names[barrierCmdHello])) == 0) {
> +        cmd = barrierCmdHello;
> +        p += strlen(cmd_names[barrierCmdHello]);
> +        len -= strlen(cmd_names[barrierCmdHello]);
> +    } else {
> +        for (cmd = 0; cmd < barrierCmdHello; cmd++) {
> +            if (memcmp(ib->buffer, cmd_names[cmd], 4) == 0) {
> +                break;
> +            }
> +        }
> +
> +        if (cmd == barrierCmdHello) {
> +            return G_SOURCE_REMOVE;
> +        }
> +        p += 4;
> +        len -= 4;
> +    }
> +
> +    msg->cmd = cmd;
> +    switch (cmd) {
> +    /* connection */
> +    case barrierCmdHello:
> +        read_short(msg->version.major, p, len);
> +        read_short(msg->version.minor, p, len);
> +        break;
> +    case barrierCmdDSetOptions:
> +        read_int(msg->set.nb, p, len);
> +        msg->set.nb /= 2;
> +        if (msg->set.nb > BARRIER_MAX_OPTIONS) {
> +            msg->set.nb = BARRIER_MAX_OPTIONS;
> +        }
> +        i = 0;
> +        while (len && i < msg->set.nb) {
> +            read_int(msg->set.option[i].id, p, len);
> +            /* it's a string, restore endianness */
> +            msg->set.option[i].id = htonl(msg->set.option[i].id);
> +            msg->set.option[i].nul = 0;
> +            read_int(msg->set.option[i].value, p, len);
> +            i++;
> +        }
> +        break;
> +    case barrierCmdQInfo:
> +        break;
> +
> +    /* mouse */
> +    case barrierCmdDMouseMove:
> +    case barrierCmdDMouseRelMove:
> +        read_short(msg->mousepos.x, p, len);
> +        read_short(msg->mousepos.y, p, len);
> +        break;
> +    case barrierCmdDMouseDown:
> +    case barrierCmdDMouseUp:
> +        read_char(msg->mousebutton.buttonid, p, len);
> +        break;
> +    case barrierCmdDMouseWheel:
> +        read_short(msg->mousepos.y, p, len);
> +        msg->mousepos.x = 0;
> +        if (len) {
> +            msg->mousepos.x = msg->mousepos.y;
> +            read_short(msg->mousepos.y, p, len);
> +        }
> +        break;
> +
> +    /* keyboard */
> +    case barrierCmdDKeyDown:
> +    case barrierCmdDKeyUp:
> +        read_short(msg->key.keyid, p, len);
> +        read_short(msg->key.modifier, p, len);
> +        msg->key.button = 0;
> +        if (len) {
> +            read_short(msg->key.button, p, len);
> +        }
> +        break;
> +    case barrierCmdDKeyRepeat:
> +        read_short(msg->repeat.keyid, p, len);
> +        read_short(msg->repeat.modifier, p, len);
> +        read_short(msg->repeat.repeat, p, len);
> +        msg->repeat.button = 0;
> +        if (len) {
> +            read_short(msg->repeat.button, p, len);
> +        }
> +        break;
> +    case barrierCmdCInfoAck:
> +    case barrierCmdCResetOptions:
> +    case barrierCmdCEnter:
> +    case barrierCmdDClipboard:
> +    case barrierCmdCKeepAlive:
> +    case barrierCmdCLeave:
> +    case barrierCmdCClose:
> +        break;
> +
> +    /* Invalid from the server */
> +    case barrierCmdHelloBack:
> +    case barrierCmdCNoop:
> +    case barrierCmdDInfo:
> +        break;
> +
> +    /* Error codes */
> +    case barrierCmdEIncompatible:
> +        read_short(msg->version.major, p, len);
> +        read_short(msg->version.minor, p, len);
> +        break;
> +    case barrierCmdEBusy:
> +    case barrierCmdEUnknown:
> +    case barrierCmdEBad:
> +        break;
> +    default:
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    return G_SOURCE_CONTINUE;
> +}
> +
> +static gboolean writecmd(InputBarrier *ib, struct barrierMsg *msg)
> +{
> +    char *p;
> +    int ret, i;
> +    int avail, len;
> +
> +    p = ib->buffer;
> +    avail = MAX_HELLO_LENGTH;
> +
> +    /* reserve space to store the length */
> +    p += sizeof(int);
> +    avail -= sizeof(int);
> +
> +    switch (msg->cmd) {
> +    case barrierCmdHello:
> +        if (msg->version.major < BARRIER_VERSION_MAJOR ||
> +            (msg->version.major == BARRIER_VERSION_MAJOR &&
> +             msg->version.minor < BARRIER_VERSION_MINOR)) {
> +            ib->ioc_tag = 0;
> +            return G_SOURCE_REMOVE;
> +        }
> +        write_cmd(p, barrierCmdHelloBack, avail);
> +        write_short(p, BARRIER_VERSION_MAJOR, avail);
> +        write_short(p, BARRIER_VERSION_MINOR, avail);
> +        write_string(p, ib->name, avail);
> +        break;
> +    case barrierCmdCClose:
> +        ib->ioc_tag = 0;
> +        return G_SOURCE_REMOVE;
> +    case barrierCmdQInfo:
> +        write_cmd(p, barrierCmdDInfo, avail);
> +        write_short(p, ib->x_origin, avail);
> +        write_short(p, ib->y_origin, avail);
> +        write_short(p, ib->width, avail);
> +        write_short(p, ib->height, avail);
> +        write_short(p, 0, avail);    /* warpsize (obsolete) */
> +        write_short(p, 0, avail);    /* mouse x */
> +        write_short(p, 0, avail);    /* mouse y */
> +        break;
> +    case barrierCmdCInfoAck:
> +        break;
> +    case barrierCmdCResetOptions:
> +        /* TODO: reset options */
> +        break;
> +    case barrierCmdDSetOptions:
> +        /* TODO: set options */
> +        break;
> +    case barrierCmdCEnter:
> +        break;
> +    case barrierCmdDClipboard:
> +        break;
> +    case barrierCmdCKeepAlive:
> +        write_cmd(p, barrierCmdCKeepAlive, avail);
> +        break;
> +    case barrierCmdCLeave:
> +        break;
> +
> +    /* mouse */
> +    case barrierCmdDMouseMove:
> +        qemu_input_queue_abs(NULL, INPUT_AXIS_X, msg->mousepos.x,
> +                             ib->x_origin, ib->width);
> +        qemu_input_queue_abs(NULL, INPUT_AXIS_Y, msg->mousepos.y,
> +                             ib->y_origin, ib->height);
> +        qemu_input_event_sync();
> +        break;
> +    case barrierCmdDMouseRelMove:
> +        qemu_input_queue_rel(NULL, INPUT_AXIS_X, msg->mousepos.x);
> +        qemu_input_queue_rel(NULL, INPUT_AXIS_Y, msg->mousepos.y);
> +        qemu_input_event_sync();
> +        break;
> +    case barrierCmdDMouseDown:
> +        qemu_input_queue_btn(NULL,
> +                             input_barrier_to_mouse(msg->mousebutton.buttonid),
> +                             true);
> +        qemu_input_event_sync();
> +        break;
> +    case barrierCmdDMouseUp:
> +        qemu_input_queue_btn(NULL,
> +                             input_barrier_to_mouse(msg->mousebutton.buttonid),
> +                             false);
> +        qemu_input_event_sync();
> +        break;
> +    case barrierCmdDMouseWheel:
> +        qemu_input_queue_btn(NULL, (msg->mousepos.y > 0) ? INPUT_BUTTON_WHEEL_UP
> +                             : INPUT_BUTTON_WHEEL_DOWN, true);
> +        qemu_input_event_sync();
> +        qemu_input_queue_btn(NULL, (msg->mousepos.y > 0) ? INPUT_BUTTON_WHEEL_UP
> +                             : INPUT_BUTTON_WHEEL_DOWN, false);
> +        qemu_input_event_sync();
> +        break;
> +
> +    /* keyboard */
> +    case barrierCmdDKeyDown:
> +        qemu_input_event_send_key_qcode(NULL,
> +                        input_barrier_to_qcode(msg->key.keyid, msg->key.button),
> +                                        true);
> +        break;
> +    case barrierCmdDKeyRepeat:
> +        for (i = 0; i < msg->repeat.repeat; i++) {
> +            qemu_input_event_send_key_qcode(NULL,
> +                  input_barrier_to_qcode(msg->repeat.keyid, msg->repeat.button),
> +                                            false);
> +            qemu_input_event_send_key_qcode(NULL,
> +                  input_barrier_to_qcode(msg->repeat.keyid, msg->repeat.button),
> +                                            true);
> +        }
> +        break;
> +    case barrierCmdDKeyUp:
> +        qemu_input_event_send_key_qcode(NULL,
> +                        input_barrier_to_qcode(msg->key.keyid, msg->key.button),
> +                                        false);
> +        break;
> +    default:
> +        write_cmd(p, barrierCmdEUnknown, avail);
> +        break;;
> +    }
> +
> +    len = MAX_HELLO_LENGTH - avail - sizeof(int);
> +    if (len) {
> +        p = ib->buffer;
> +        avail = sizeof(len);
> +        write_int(p, len, avail);
> +        ret = qio_channel_write(QIO_CHANNEL(ib->sioc), ib->buffer,
> +                                len + sizeof(len), NULL);
> +        if (ret < 0) {
> +            ib->ioc_tag = 0;
> +            return G_SOURCE_REMOVE;
> +        }
> +    }
> +
> +    return G_SOURCE_CONTINUE;
> +}
> +
> +static gboolean input_barrier_event(QIOChannel *ioc G_GNUC_UNUSED,
> +                                    GIOCondition condition, void *opaque)
> +{
> +    InputBarrier *ib = opaque;
> +    int ret;
> +    struct barrierMsg msg;
> +
> +    ret = readcmd(ib, &msg);
> +    if (ret == G_SOURCE_REMOVE) {
> +        ib->ioc_tag = 0;
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    return writecmd(ib, &msg);
> +}
> +
> +static void input_barrier_complete(UserCreatable *uc, Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(uc);
> +    Error *local_err = NULL;
> +
> +    if (!ib->name) {
> +        error_setg(errp, QERR_MISSING_PARAMETER, "name");
> +        return;
> +    }
> +
> +    /*
> +     * Connect to the primary
> +     * Primary is the server where the keyboard and the mouse
> +     * are connected and forwarded to the secondary (the client)
> +     */
> +
> +    ib->sioc = qio_channel_socket_new();
> +    qio_channel_set_name(QIO_CHANNEL(ib->sioc), "barrier-client");
> +
> +    qio_channel_socket_connect_sync(ib->sioc, &ib->saddr, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    qio_channel_set_delay(QIO_CHANNEL(ib->sioc), false);
> +
> +    ib->ioc_tag = qio_channel_add_watch(QIO_CHANNEL(ib->sioc), G_IO_IN,
> +                                        input_barrier_event, ib, NULL);
> +}
> +
> +static void input_barrier_instance_finalize(Object *obj)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +
> +    if (ib->ioc_tag) {
> +        g_source_remove(ib->ioc_tag);
> +        ib->ioc_tag = 0;
> +    }
> +
> +    if (ib->sioc) {
> +        qio_channel_close(QIO_CHANNEL(ib->sioc), NULL);
> +        object_unref(OBJECT(ib->sioc));
> +    }
> +    g_free(ib->name);
> +    g_free(ib->saddr.u.inet.host);
> +    g_free(ib->saddr.u.inet.port);
> +}
> +
> +static char *input_barrier_get_name(Object *obj, Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +
> +    return g_strdup(ib->name);
> +}
> +
> +static void input_barrier_set_name(Object *obj, const char *value,
> +                                  Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +
> +    if (ib->name) {
> +        error_setg(errp, "name property already set");
> +        return;
> +    }
> +    ib->name = g_strdup(value);
> +}
> +
> +static char *input_barrier_get_server(Object *obj, Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +
> +    return g_strdup(ib->saddr.u.inet.host);
> +}
> +
> +static void input_barrier_set_server(Object *obj, const char *value,
> +                                     Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +
> +    g_free(ib->saddr.u.inet.host);
> +    ib->saddr.u.inet.host = g_strdup(value);
> +}
> +
> +static char *input_barrier_get_port(Object *obj, Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +
> +    return g_strdup(ib->saddr.u.inet.port);
> +}
> +
> +static void input_barrier_set_port(Object *obj, const char *value,
> +                                     Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +
> +    g_free(ib->saddr.u.inet.port);
> +    ib->saddr.u.inet.port = g_strdup(value);
> +}
> +
> +static void input_barrier_set_x_origin(Object *obj, const char *value,
> +                                       Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +    int result, err;
> +
> +    err = qemu_strtoi(value, NULL, 0, &result);
> +    if (err < 0 || result < 0 || result > SHRT_MAX) {
> +        error_setg(errp,
> +                   "x-origin property must be in the range [0..%d]", SHRT_MAX);
> +        return;
> +    }
> +    ib->x_origin = result;
> +}
> +
> +static char *input_barrier_get_x_origin(Object *obj, Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +
> +    return g_strdup_printf("%d", ib->x_origin);
> +}
> +
> +static void input_barrier_set_y_origin(Object *obj, const char *value,
> +                                       Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +    int result, err;
> +
> +    err = qemu_strtoi(value, NULL, 0, &result);
> +    if (err < 0 || result < 0 || result > SHRT_MAX) {
> +        error_setg(errp,
> +                   "y-origin property must be in the range [0..%d]", SHRT_MAX);
> +        return;
> +    }
> +    ib->y_origin = result;
> +}
> +
> +static char *input_barrier_get_y_origin(Object *obj, Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +
> +    return g_strdup_printf("%d", ib->y_origin);
> +}
> +
> +static void input_barrier_set_width(Object *obj, const char *value,
> +                                       Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +    int result, err;
> +
> +    err = qemu_strtoi(value, NULL, 0, &result);
> +    if (err < 0 || result < 0 || result > SHRT_MAX) {
> +        error_setg(errp,
> +                   "width property must be in the range [0..%d]", SHRT_MAX);
> +        return;
> +    }
> +    ib->width = result;
> +}
> +
> +static char *input_barrier_get_width(Object *obj, Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +
> +    return g_strdup_printf("%d", ib->width);
> +}
> +
> +static void input_barrier_set_height(Object *obj, const char *value,
> +                                       Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +    int result, err;
> +
> +    err = qemu_strtoi(value, NULL, 0, &result);
> +    if (err < 0 || result < 0 || result > SHRT_MAX) {
> +        error_setg(errp,
> +                   "height property must be in the range [0..%d]", SHRT_MAX);
> +        return;
> +    }
> +    ib->height = result;
> +}
> +
> +static char *input_barrier_get_height(Object *obj, Error **errp)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +
> +    return g_strdup_printf("%d", ib->height);
> +}
> +
> +static void input_barrier_instance_init(Object *obj)
> +{
> +    InputBarrier *ib = INPUT_BARRIER(obj);
> +
> +    ib->saddr.type = SOCKET_ADDRESS_TYPE_INET;
> +    ib->saddr.u.inet.host = g_strdup("localhost");
> +    ib->saddr.u.inet.port = g_strdup("24800");
> +
> +    ib->x_origin = 0;
> +    ib->y_origin = 0;
> +    ib->width = 1920;
> +    ib->height = 1080;
> +
> +    object_property_add_str(obj, "name",
> +                            input_barrier_get_name,
> +                            input_barrier_set_name, NULL);
> +    object_property_add_str(obj, "server",
> +                            input_barrier_get_server,
> +                            input_barrier_set_server, NULL);
> +    object_property_add_str(obj, "port",
> +                            input_barrier_get_port,
> +                            input_barrier_set_port, NULL);
> +    object_property_add_str(obj, "x-origin",
> +                            input_barrier_get_x_origin,
> +                            input_barrier_set_x_origin, NULL);
> +    object_property_add_str(obj, "y-origin",
> +                            input_barrier_get_y_origin,
> +                            input_barrier_set_y_origin, NULL);
> +    object_property_add_str(obj, "width",
> +                            input_barrier_get_width,
> +                            input_barrier_set_width, NULL);
> +    object_property_add_str(obj, "height",
> +                            input_barrier_get_height,
> +                            input_barrier_set_height, NULL);
> +}
> +
> +static void input_barrier_class_init(ObjectClass *oc, void *data)
> +{
> +    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
> +
> +    ucc->complete = input_barrier_complete;
> +
> +    /* always use generic keymaps */
> +    if (keyboard_layout) {
> +        /* We use X11 key id, so use VNC name2keysym */
> +        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
> +                                          &error_fatal);
> +    }
> +}
> +
> +static const TypeInfo input_barrier_info = {
> +    .name = TYPE_INPUT_BARRIER,
> +    .parent = TYPE_OBJECT,
> +    .class_size = sizeof(InputBarrierClass),
> +    .class_init = input_barrier_class_init,
> +    .instance_size = sizeof(InputBarrier),
> +    .instance_init = input_barrier_instance_init,
> +    .instance_finalize = input_barrier_instance_finalize,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&input_barrier_info);
> +}
> +
> +type_init(register_types);
> diff --git a/ui/input-barrier.h b/ui/input-barrier.h
> new file mode 100644
> index 000000000000..e5b090590ad5
> --- /dev/null
> +++ b/ui/input-barrier.h
> @@ -0,0 +1,112 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef UI_INPUT_BARRIER_H
> +#define UI_INPUT_BARRIER_H
> +
> +/* Barrier protocol */
> +#define BARRIER_VERSION_MAJOR 1
> +#define BARRIER_VERSION_MINOR 6
> +
> +enum barrierCmd {
> +    barrierCmdCNoop,
> +    barrierCmdCClose,
> +    barrierCmdCEnter,
> +    barrierCmdCLeave,
> +    barrierCmdCClipboard,
> +    barrierCmdCScreenSaver,
> +    barrierCmdCResetOptions,
> +    barrierCmdCInfoAck,
> +    barrierCmdCKeepAlive,
> +    barrierCmdDKeyDown,
> +    barrierCmdDKeyRepeat,
> +    barrierCmdDKeyUp,
> +    barrierCmdDMouseDown,
> +    barrierCmdDMouseUp,
> +    barrierCmdDMouseMove,
> +    barrierCmdDMouseRelMove,
> +    barrierCmdDMouseWheel,
> +    barrierCmdDClipboard,
> +    barrierCmdDInfo,
> +    barrierCmdDSetOptions,
> +    barrierCmdDFileTransfer,
> +    barrierCmdDDragInfo,
> +    barrierCmdQInfo,
> +    barrierCmdEIncompatible,
> +    barrierCmdEBusy,
> +    barrierCmdEUnknown,
> +    barrierCmdEBad,
> +    /* connection sequence */
> +    barrierCmdHello,
> +    barrierCmdHelloBack,
> +};
> +
> +enum {
> +   barrierButtonNone,
> +   barrierButtonLeft,
> +   barrierButtonMiddle,
> +   barrierButtonRight,
> +   barrierButtonExtra0
> +};
> +
> +struct barrierVersion {
> +    int16_t major;
> +    int16_t minor;
> +};
> +
> +struct barrierMouseButton {
> +    int8_t buttonid;
> +};
> +
> +struct barrierEnter {
> +    int16_t x;
> +    int16_t y;
> +    int32_t seqn;
> +    int16_t modifier;
> +};
> +
> +struct barrierMousePos {
> +    int16_t x;
> +    int16_t y;
> +};
> +
> +struct barrierKey {
> +    int16_t keyid;
> +    int16_t modifier;
> +    int16_t button;
> +};
> +
> +struct barrierRepeat {
> +    int16_t keyid;
> +    int16_t modifier;
> +    int16_t repeat;
> +    int16_t button;
> +};
> +
> +#define BARRIER_MAX_OPTIONS 32
> +struct barrierSet {
> +    int nb;
> +    struct {
> +        int id;
> +        char nul;
> +        int value;
> +    } option[BARRIER_MAX_OPTIONS];
> +};
> +
> +struct barrierMsg {
> +    enum barrierCmd cmd;
> +    union {
> +        struct barrierVersion version;
> +        struct barrierMouseButton mousebutton;
> +        struct barrierMousePos mousepos;
> +        struct barrierEnter enter;
> +        struct barrierKey key;
> +        struct barrierRepeat repeat;
> +        struct barrierSet set;
> +    };
> +};
> +#endif
> 


