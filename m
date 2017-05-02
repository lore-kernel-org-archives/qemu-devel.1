Received: from eggs.gnu.org ([2001:4830:134:3::10]:33563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1d5cUL-0002mH-RO
	for qemu-devel@nongnu.org; Tue, 02 May 2017 14:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1d5cUI-0000LQ-Og
	for qemu-devel@nongnu.org; Tue, 02 May 2017 14:25:29 -0400
Received: from mail-it0-x232.google.com ([2607:f8b0:4001:c0b::232]:36532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patrick.ohly@intel.com>)
	id 1d5cUI-0000JG-IB
	for qemu-devel@nongnu.org; Tue, 02 May 2017 14:25:26 -0400
Received: by mail-it0-x232.google.com with SMTP id o5so17641379ith.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 11:25:23 -0700 (PDT)
Message-ID: <1493749518.4241.225.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
Date: Tue, 02 May 2017 20:25:18 +0200
In-Reply-To: <5ee48b85-0404-a810-95b5-4b19b197373e@linux.vnet.ibm.com>
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-9-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
	<38a2aa2e-6270-63af-3dec-bd666d56780d@linux.vnet.ibm.com>
	<CAJ+F1CKcZvWE4OQOMKuDqNvKGEQK3DdihM6Eyx-piqtQtSbXGQ@mail.gmail.com>
	<5ee48b85-0404-a810-95b5-4b19b197373e@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org

On Tue, 2017-05-02 at 13:19 -0400, Stefan Berger wrote:
> On 05/02/2017 01:09 PM, Marc-André Lureau wrote:
> > On Tue, May 2, 2017 at 8:59 PM Stefan Berger <stefanb@linux.vnet.ibm.com>
> > wrote:
> >
> >> And who is going to implement that qemu-swtpm? Obviously this discussion
> >> doesn't contribute to progress if nobody is doing that in the end.
> >>
> > The same persons who try to push for that emulated TPM code. The easiest
> > approach would be to copy/adapt the swtpm code in qemu, if the licence is
> > compatible. I can help with that if there is a consensus it's a better
> > approach.
> 
> 
> It's a matter of time and at least I don't have time for that.

Neither do I, and nor (I believe) does Amarnath. The approach with using
the existing swtpm project seemed attractive to us exactly because it
avoids having to write and maintain more than just the glue code between
the two projects.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
