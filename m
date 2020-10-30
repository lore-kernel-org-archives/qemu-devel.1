Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ABAC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256242075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256242075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=movementarian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXrU-00027u-2A
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <movement@li1368-133.members.linode.com>)
 id 1kYXo3-0008FU-Br
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:03:15 -0400
Received: from ssh.movementarian.org ([2a01:7e00::f03c:92ff:fefb:3ad2]:59820
 helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <movement@li1368-133.members.linode.com>)
 id 1kYXo1-0005iF-41
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:03:14 -0400
Received: from movement by movementarian.org with local (Exim 4.93)
 (envelope-from <movement@li1368-133.members.linode.com>)
 id 1kYXnu-00Agre-GO; Fri, 30 Oct 2020 17:03:06 +0000
Date: Fri, 30 Oct 2020 17:03:06 +0000
From: John Levon <levon@movementarian.org>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH v5] introduce vfio-user protocol specification
Message-ID: <20201030170306.GA2544852@li1368-133.members.linode.com>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <20201028161005.115810-1-thanos.makatos@nutanix.com>
 <SN1PR02MB3725C85DCD4BF652FF6FBB8D8B170@SN1PR02MB3725.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN1PR02MB3725C85DCD4BF652FF6FBB8D8B170@SN1PR02MB3725.namprd02.prod.outlook.com>
X-Url: http://www.movementarian.org/
Received-SPF: none client-ip=2a01:7e00::f03c:92ff:fefb:3ad2;
 envelope-from=movement@li1368-133.members.linode.com; helo=movementarian.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 20
X-Spam_score: 2.0
X-Spam_bar: ++
X-Spam_report: (2.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, KHOP_HELO_FCRDNS=0.276,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_FAIL=0.001, SPF_NONE=0.001,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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
Cc: "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 28, 2020 at 04:41:31PM +0000, Thanos Makatos wrote:

> FYI here's v5 of the vfio-user protocol, my --cc in git send-email got messed up somehow

Hi Thanos, this looks great, I just had some minor questions below.

> Command Concurrency
> -------------------
> A client may pipeline multiple commands without waiting for previous command
> replies.  The server will process commands in the order they are received.
> A consequence of this is if a client issues a command with the *No_reply* bit,
> then subseqently issues a command without *No_reply*, the older command will
> have been processed before the reply to the younger command is sent by the
> server.  The client must be aware of the device's capability to process concurrent
> commands if pipelining is used.  For example, pipelining allows multiple client
> threads to concurently access device memory; the client must ensure these acceses
> obey device semantics.
> 
> An example is a frame buffer device, where the device may allow concurrent access
> to different areas of video memory, but may have indeterminate behavior if concurrent
> acceses are performed to command or status registers.

Is it valid for an unrelated server->client message to appear in between a
client->server request/reply, or not? And vice versa? Either way, seems useful
for the spec to say.

> |                | +-----+------------+ |
> |                | | Bit | Definition | |
> |                | +=====+============+ |
> |                | | 0-3 | Type       | |
> |                | +-----+------------+ |
> |                | | 4   | No_reply   | |
> |                | +-----+------------+ |
> |                | | 5   | Error      | |
> |                | +-----+------------+ |
> +----------------+--------+-------------+
> | Error          | 12     | 4           |
> +----------------+--------+-------------+
> 
> * *Message ID* identifies the message, and is echoed in the command's reply message.

Is it valid to re-use an ID? When/when not?

>   * *Error* in a reply message indicates the command being acknowledged had
>     an error. In this case, the *Error* field will be valid.
> 
> * *Error* in a reply message is a UNIX errno value. It is reserved in a command message.

I'm not quite following why we need a bit flag and an error field. Do you
anticipate a failure, but with errno==0?

> VFIO_USER_VERSION
> -----------------
> 
> +--------------+------------------------+
> | Message size | 16 + version length    |

Terminating NUL included?

> +--------------+--------+---------------------------------------------------+
> | Name         | Type   | Description                                       |
> +==============+========+===================================================+
> | version      | object | ``{"major": <number>, "minor": <number>}``        |
> |              |        |                                                   |
> |              |        | Version supported by the sender, e.g. "0.1".      |

It seems quite unlikely but this should specify it's strings not floating point
values maybe?

Definitely applies to max_fds too.

> Common capabilities:
> 
> +---------------+------------------------------------------------------------+
> | Name          | Description                                                |
> +===============+============================================================+
> | ``max_fds``   | Maximum number of file descriptors that can be received by |
> |               | the sender. Optional.                                      |

Could specify the meaning when absent?

By array I presume you mean associative array i.e. an Object. Does the whole
thing look like this:

 {
   "major": ..
   "minor": ..
   "capabilities": {
      "max_fds": ..,
      "migration
   }
 }

or something else?

> Versioning and Feature Support
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Upon accepting a connection, the server must send a VFIO_USER_VERSION message
> proposing a protocol version and a set of capabilities. The client compares
> these with the versions and capabilities it supports and sends a
> VFIO_USER_VERSION reply according to the following rules.

I'm curious if there was a specific reason it's this way around, when it seems
more natural for the client to propose first, and the server to reply?

> VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP
> -----------------------------------------

Huge nit, but why are these DMA_*MAP when vfio uses *MAP_DMA ?

> VFIO bitmap format
> * *size* the size for the bitmap, in bytes.

Should this clarify it does *not* include the bitmap header in its size, unlike
other size fields?

> VFIO_USER_DMA_MAP
> """""""""""""""""
> If a DMA region being added can be directly mapped by the server, an array of
> file descriptors must be sent as part of the message meta-data. Each region
> entry must have a corresponding file descriptor.

"Each mappable region entry" ?

> descriptors must be passed as SCM_RIGHTS type ancillary data. Otherwise, if a
> DMA region cannot be directly mapped by the server, it can be accessed by the
> server using VFIO_USER_DMA_READ and VFIO_USER_DMA_WRITE messages, explained in
> `Read and Write Operations`_. A command to map over an existing region must be
> failed by the server with ``EEXIST`` set in error field in the reply.
> 
> VFIO_USER_DMA_UNMAP
> """""""""""""""""""
> Upon receiving a VFIO_USER_DMA_UNMAP command, if the file descriptor is mapped
> then the server must release all references to that DMA region before replying,
> which includes potentially in flight DMA transactions. Removing a portion of a
> DMA region is possible. If the VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP bit is set
> in the request, the server must append to the header the ``struct vfio_bitmap``
> received in the command, followed by the bitmap. Thus, the message size the
> client should is expect is the size of the header plus the size of
> ``struct vfio_bitmap`` plus ``vfio_bitmap.size`` bytes. Each bit in the bitmap
> represents one page of size ``vfio_bitmap.pgsize``.

I'm finding this makes the sizing a bit confusing between map and unmap, could
we may be separate them out, and always define a vfio_bitmap slot for unmap?

Also, shouldn't the client expect sizeof (header) + (nr_table_entries_in_request
* (each vfio_bitmap's size))  in the server's response?

Does the reply header size field reflect this?

> VFIO_USER_DMA_WRITE
> -------------------
> 
> This command message is sent from the server to the client to write to server
> memory.

"write to client memory"?

> VFIO_USER_DIRY_PAGES

Nit, "DIRTY"

thanks
john

