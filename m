Received: from eggs.gnu.org ([2001:4830:134:3::10]:44810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVKS2-0005uw-C9
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVKRz-0006U1-8B
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:25:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVKRz-0006Es-04
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:25:19 -0400
Received: by mail-wr0-f196.google.com with SMTP id y28so2382421wrd.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 09:24:56 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712150400.GH5237@redhat.com>
	<9d51d348-7ad6-a98d-3f6d-89e8af5e3a16@redhat.com>
	<20170712161254.GJ5237@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d3c71dc9-1286-802a-b663-7d37f97daf72@redhat.com>
Date: Wed, 12 Jul 2017 18:23:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170712161254.GJ5237@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12/07/2017 18:12, Daniel P. Berrange wrote:
>> I'm still not 100% sure whether that auto-deprecation of machine types
>> is such a good idea ... since we might need to maintain machines in
>> downstream a little bit longer than specified there, it might be better
>> to rather deprecate them manually from time to time.
> 
> Downstreams usually maintain custom machine types, so fact that the
> upstream machine types get deleted is not a problem in itself. The problem
> comes if followup internal code removal then prevents downstream from
> creating their custom machine type.  I don't think we need tie these
> issues together. We can remove old machine types, without immediately
> removing features that our harm creation of downstream machine types.

I think machine type and feature removal should be tied together.

Doing the opposite leaves around code that is more or less dead from an
upstream point of view, and looks like an ad hoc rule for Red Hat.  It
harms downstreams that do not participate in upstream development
(though perhaps this is an intended side effect?).

Paolo
