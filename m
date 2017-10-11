Received: from eggs.gnu.org ([2001:4830:134:3::10]:38431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2My2-00088W-Ra
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2Mxz-0002rZ-PH
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:46:58 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:54799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e2Mxz-0002qv-Hx
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:46:55 -0400
Received: by mail-wm0-f44.google.com with SMTP id i124so7799838wmf.3
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 12:46:54 -0700 (PDT)
References: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
	<62e835a4-ba5d-e620-47d2-180932a33426@redhat.com>
	<20171006135425.GF26575@redhat.com>
	<CAEfK_444_fPwjnj1M8w8XNFFwiMJW-pdN7R1Tdu+FfvB38ZBtw@mail.gmail.com>
	<20171006140137.GH26575@redhat.com>
	<CAEfK_455Hr1afv-H6=9QMQErDGZJtOBgFMk2F8QJshYTLgOa1Q@mail.gmail.com>
	<e46a6b2d-83e2-d558-028c-94ad41af8fa2@redhat.com>
	<CAEfK_44_43d5_KaGUf-FH7bHxre5BP1wCQu96p38bhskUqU+Ug@mail.gmail.com>
	<87h8v7lcan.fsf@dusky.pond.sub.org>
	<20171010080201.GB4177@dhcp-200-186.str.redhat.com>
	<CAFEAcA-jb=4eTgD836+darXBLBuDA70pcypON2Bbj3b0SpNTaQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <35705b3e-ccdd-c1af-2dd5-688a1c7e837a@redhat.com>
Date: Wed, 11 Oct 2017 21:46:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-jb=4eTgD836+darXBLBuDA70pcypON2Bbj3b0SpNTaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] Patch to add helpful tracing output
 for driver authors in NVMe emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Doug Gale <doug16k@gmail.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>

On 11/10/2017 15:08, Peter Maydell wrote:
>> Tracing is the right tool to detect bad guest code, and I think it makes
>> sense to mark conditions that shouldn't happen with a correctly
>> operating guest driver. I'm not sure if an exclamation mark is the best
>> syntax for this, because I wouldn't have intuitively understood what
>> it's supposed to tell me.
> We have qemu_log_mask(LOG_GUEST_ERROR, ...) for logging guest errors,
> so I think we should use that.

LOG_GUEST_ERROR is something different too.  It means something that is
undefined according to the data sheet more or less, such as accessing a
non-existent reference.

Here the driver does some validation of the values that were written in
the registers, and tells the guest if the validation fails (by putting
something in another registers).  Using a tracepoint sounds like the
right thing to do.

Paolo
