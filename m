Received: from eggs.gnu.org ([2001:4830:134:3::10]:46576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1d6DJr-0003qx-FA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1d6DJo-0003Tt-BQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:45:07 -0400
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235]:33717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patrick.ohly@intel.com>)
	id 1d6DJo-0003TS-3G
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:45:04 -0400
Received: by mail-io0-x235.google.com with SMTP id p24so15541217ioi.0
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 02:45:03 -0700 (PDT)
Message-ID: <1493891098.4241.285.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
Date: Thu, 04 May 2017 11:44:58 +0200
In-Reply-To: <14dc8420-0a21-b92e-4e50-a92676d35b96@linux.vnet.ibm.com>
References: <CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
	<38a2aa2e-6270-63af-3dec-bd666d56780d@linux.vnet.ibm.com>
	<CAJ+F1CKcZvWE4OQOMKuDqNvKGEQK3DdihM6Eyx-piqtQtSbXGQ@mail.gmail.com>
	<5ee48b85-0404-a810-95b5-4b19b197373e@linux.vnet.ibm.com>
	<1493749518.4241.225.camel@intel.com>
	<CAJ+F1CK4jN2Nb6eKB1x9Km0xnurs976=Kb0idFpPgtH+JHYTcQ@mail.gmail.com>
	<b6e0d6d2-d276-c66d-ae5e-c6502cbe0b5c@linux.vnet.ibm.com>
	<20170503084136.GC4121@redhat.com> <20170503111659.GA2077@work-vm>
	<CAJ+F1CJ2JnLS2BbMWES0HQ3-iJUzXrrj21RVPo70d04xpWbgDQ@mail.gmail.com>
	<20170503112948.GA3985@redhat.com>
	<14dc8420-0a21-b92e-4e50-a92676d35b96@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org

On Wed, 2017-05-03 at 10:42 -0400, Stefan Berger wrote:
>   - the TPM 2 part , as stated before, is still somewhat in flux. I am 
> not sure when there will be a final TPM 2 from TCG. There the 
> possibility exists that the state blobs the TPM 2 is writing out still 
> change. I have added a version tag in front of the blobs so in case 
> something else gets added that that can be accommodated. Besides that 
> it's also adapted to write the state blobs in big endian format for the 
> same reason as above. Maybe at some point I'll just freeze the code and 
> don't follow the ongoing TPM 2 development anymore besides bug fixes to 
> exsting code, which then freezes the state blobs as well.

Ignoring the "work in progress" status of TPM 2 and your
https://github.com/stefanberger/swtpm/tree/tpm2-preview branch, should
your current code already also work with the qemu device backend that is
getting discussed here?

In other words, are protocol changes needed? I know that TPM 2 has
changed the commands, but I don't know whether that affects also the
lower layers.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
