Received: from eggs.gnu.org ([2001:4830:134:3::10]:47073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1cxWEW-0007zW-FJ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1cxWES-0004b5-Gx
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:07:40 -0400
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:35336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patrick.ohly@intel.com>)
	id 1cxWES-0004aV-9e
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:07:36 -0400
Received: by mail-io0-x22f.google.com with SMTP id r16so35135664ioi.2
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 03:07:35 -0700 (PDT)
Message-ID: <1491818850.10884.99.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
Date: Mon, 10 Apr 2017 12:07:30 +0200
In-Reply-To: <CAJ+F1CKo=tAXKHzoY4mfZxc9V2N5+sszOJwPOVqkJZK2tD6vMA@mail.gmail.com>
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
	<1491575431-32170-10-git-send-email-amarnath.valluri@intel.com>
	<20170407144100.GL26896@redhat.com>
	<CAJ+F1CJ1wfP_RS25=gokRvk2y0+-_7pX8adzmBUMZPpaz=AOgw@mail.gmail.com>
	<094e28c1-b780-f8ff-fc6a-9f6dd3421a3a@intel.com>
	<CAJ+F1CKo=tAXKHzoY4mfZxc9V2N5+sszOJwPOVqkJZK2tD6vMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 9/9] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com

On Mon, 2017-04-10 at 09:54 +0000, Marc-André Lureau wrote:

> By "public protocol", I mean qemu communication with a foreign
> project, swtpm or other.
> 
> If qemu grows new needs, or if the protocol is found limited or buggy,
> it may change. Subtle interactions may break between various
> implementations.  The minimum would be some versioning or
> capabilities. A document describing the states and messages
> allowed/denied & effects would be quite necessary.

Stefan, is there any documentation besides the source?

Just asking, I don't think it is needed because...

> Otoh, there doesn't seem to be other users of this protocol, or other
> implementations. So it may make sense to make it qemu-specific, and
> thus "private": the protocol and implementation can evolve without
> risk to break other users. This gives us a lot more flexibility and
> control, and doesn't have to be very strictly documented (although it
> is still better to be strict, but requires more effort).

... I suspect it falls into this camp. I can't think of any users of the
protocol besides swtpm itself and now qemu. Stefan, is that correct?

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
