Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76B5C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A496F208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A496F208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2t6R-00084T-Pp
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 04:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i2t5j-0007dS-ND
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i2t5i-0002Lz-Bq
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:14:07 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:53907)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i2t5i-0002KO-2w
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:14:06 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1McY0L-1idbHm3Dxd-00cvht; Wed, 28 Aug 2019 10:13:59 +0200
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20190827192526.21780-1-laurent@vivier.eu>
 <20190828061103.u4l4inomwfvbodtn@sirius.home.kraxel.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <79ea4476-f2ae-4b6f-1f65-48de3b0ffebd@vivier.eu>
Date: Wed, 28 Aug 2019 10:13:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828061103.u4l4inomwfvbodtn@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:d2TfAMBIh3HjMbqEho8yCqdJFOR90HtVCwqf93EXPzwXeNNv+zE
 +gRV+dwJJ+N0lLId8FdRMGbeGKs8J/q5tNGkhn6+0kB8+HHOOPh+bFzMX2TV6FpK6XDzpSw
 XATgWfm1+Vs1orBNjhIFjGqSmw4dHuaV2skeQzz+QwZpmWunMlucqBG5j4HSqJsnG4HUEc5
 PN1lZ5k47bUvXffFe1riQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R5ga+JEH8iY=:Upct2/88LOEDwIK1dWTMAh
 XXlqM4KDh6zXdoJsFYcMPEcMkmc8MkyDKZdi1oxmMKGk+GljkjOuTzOyws6gr7KaqOrhPXrGC
 L+6HpDfGEvMWHJGE04YAg3hf1pKqmTtv/gfmfTuZK5hJFxG1exU+d34N9jKJJgFE5Qic01ukN
 7YE9CNjc0MxlknmYz9YRUx/4sSvIvnoTwJXhg1nfNTKWN6Kir2aCc1gokNJU75tJRzRSinFlt
 OoI6U8G97Ns//IwwRbyhyvC+Bw3O5PXxzZFAG7FLUpNYmJffmzgEB9TNqqFL5K8WTAm6n5Cvo
 t15dQ7y/MdPnJnoeQ2jzz43YnUsRFhk7od9VBlCEY1Zk+pwjVUCZ30GegEXnKsWrvaes9x90H
 x2MXV3hb/RKsdFudpgNq9AYO9Uir52qA4y2/DrSfnQuIjEBsypCI3wdqiRzPJQSY33z5aKL49
 k0qtUQ2J5ltCVmHa+ZkXdFZo035dNQE3/SplXffvYgI3kyg5oz7Z9Fugl0VQaxQGY8oxqgCis
 OAYaHOIEcZlMxqP7NnXZyu2CeiaHe3vpBxvdjz6RMumAttDvicl7+ccVgk1iIxDgHEvVUXa9J
 uGND9lM921jtHNK6xFASiMfaHdoN8u3kPdkP1UZKYM0oiH0mPD4tZBSBNhjhY/PWjGdIrvhAR
 C4kcui+oHuhBOkgL9JnnxOvMT4bflllgWT3XQsVBCxwMO43GVqhVjdxX/Op0AbneHzpVGzdZ9
 rImMpea+vRhzRDwTw5ncxoOGTtraszSHB15ILW2bA6CCSDNMaoHUgMOLUcA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: Re: [Qemu-devel] [RFC,Draft] ui: add an embedded Barrier client
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
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Le 28/08/2019 à 08:11, Gerd Hoffmann a écrit :
>   Hi,
> 
>> For instance:
>>
>>   section: screens
>>       localhost:
>>           ...
>>       VM-1:
>>           ...
>>       end
>>
>>   section: links
>>       localhost:
>>           right = VM-1
>>       VM-1:
>>           left = localhost
>>   end
>>
>> Then on the QEMU command line:
>>
>>     ... -object input-barrier,id=barrie0,name=VM-1 ...
>>
>> When the mouse will move out of the screen of the local host on
>> the right, the mouse and the keyboard will be grabbed and all
>> related events will be send to the guest OS.
> 
> Put that into docs/ ?

Yes, I'll add more docs once the code is ready.

> 
>> +#define BARRIER_VERSION_MAJOR 1
>> +#define BARRIER_VERSION_MINOR 6
>> +
>> +enum cmdids {
>> +    MSG_CNoop,
>> +    MSG_CClose,
>> +    MSG_CEnter,
>> +    MSG_CLeave,
>> +    MSG_CClipboard,
>> +    MSG_CScreenSaver,
>> +    MSG_CResetOptions,
>> +    MSG_CInfoAck,
>> +    MSG_CKeepAlive,
>> +    MSG_DKeyDown,
>> +    MSG_DKeyRepeat,
>> +    MSG_DKeyUp,
>> +    MSG_DMouseDown,
>> +    MSG_DMouseUp,
>> +    MSG_DMouseMove,
>> +    MSG_DMouseRelMove,
>> +    MSG_DMouseWheel,
>> +    MSG_DClipboard,
>> +    MSG_DInfo,
>> +    MSG_DSetOptions,
>> +    MSG_DFileTransfer,
>> +    MSG_DDragInfo,
>> +    MSG_QInfo,
>> +    MSG_EIncompatible,
>> +    MSG_EBusy,
>> +    MSG_EUnknown,
>> +    MSG_EBad,
>> +    /* connection sequence */
>> +    MSG_Hello,
>> +    MSG_HelloBack,
>> +};
> 
> Put that into a barrier-protocol header file?

I agree.

>> +    case MSG_QInfo:
>> +        p = write_cmd(ib, p, MSG_DInfo);
>> +        p = write_short(ib, p, 0);    /* x origin */
>> +        p = write_short(ib, p, 0);    /* y origin */
>> +        p = write_short(ib, p, 1920); /* width */
>> +        p = write_short(ib, p, 1080); /* height */
> 
> Hmm.
> 
> This is the screen size I guess?  Which you don't know ...
> What this is used for?
> Should we maybe use INPUT_EVENT_ABS_MAX here?
> 

Yes, it's screen size but we can't use INPUT_EVENT_ABS_MAX.

In fact Barrier can manage more than 2 displays:

   0            x1           x2           x3

0  +------------+------------+------------+---
   |            |            |            |
   |  localhost |    VM-1    |   VM-2     |
   |            |            |            |
y1 +------------+------------+------------+---
   |            |            |            |
   | remotehost |            |            |
   |            |            |            |
y2 +------------+------------+------------+---
   |            |            |            |

So Barrier will send events to localhost while x(mouse) is between 0 and
x1, to VM-1 while it is between x1 and x2, and to VM-2 between x2 and
x3. So we need to know the size of the display to have x2.

Normally when the barrier client runs into an OS it intercepts the
screen resizing information and send them to the server. In our case we
cannot (for instance if we use a vfio display) but I plan to add
properties to the input-barrier object to provide the information at
least statically.

>> +    case MSG_DMouseMove:
>> +        qemu_input_queue_abs(NULL, INPUT_AXIS_X, msg.mousepos.x, 0, 1920);
>> +        qemu_input_queue_abs(NULL, INPUT_AXIS_Y, msg.mousepos.y, 0, 1080);
> 
> ... and here too of course.
> 
>> +    addr.type = SOCKET_ADDRESS_TYPE_INET;
>> +    addr.u.inet.host = g_strdup("localhost");
>> +    addr.u.inet.port = g_strdup("24800");
> 
> Does it make sens to allow connecting to other machines?
> Or will the barrier daemon run on every machine anyway?

The barrier server runs only on the machine with the mouse and the
keyboard. Other machines have normally the barrier client daemon to
inject the mouse and keyboard events in the OS.

But we can imagine to have a remote host with a VM inside we want to
access from our local host. So, yes, I think it makes sens to allow
connecting to other machine. I will add that too.

I will try to add a keyboard remapping as we have with VNC because it
doesn't work well with my french keyboard (AZERTY). Or perhaps I can use
the "button" id instead of the keyid but I don't now how to map the
value to a qcode.

Thanks,
Laurent


