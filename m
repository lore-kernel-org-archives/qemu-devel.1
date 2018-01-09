Received: from eggs.gnu.org ([2001:4830:134:3::10]:35994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYxnb-00084p-K1
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYxnY-0007UM-Hr
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:34:55 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eYxnY-0007TP-BB
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:34:52 -0500
Received: by mail-wm0-f65.google.com with SMTP id i11so22117880wmf.4
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 09:34:51 -0800 (PST)
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>
	<20180109121653.GN2131@umbus.fritz.box>
	<CAFEAcA-Mzyf2S3yW04LNVy7pAZ6gmzXo3aiFdPxrbWAAAX7N0Q@mail.gmail.com>
	<151551377581.2579.2269090053428846143@sif>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <25942882-8dfd-87f4-7822-3d46ee303370@redhat.com>
Date: Tue, 9 Jan 2018 18:34:48 +0100
MIME-Version: 1.0
In-Reply-To: <151551377581.2579.2269090053428846143@sif>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, surajjs@au1.ibm.com

On 09/01/2018 17:02, Michael Roth wrote:
>> so you can see it's already diverged because it prints out
>> a different value for the name of the pci node and the
>> SCSI line has 8200000000000000 vs 00000000.
> FYI I actually see this with a raspberry pi 3 too

Is this an arm32 or aarch64 install?  From Peter's report, I am tempted
to blame the ARM backend (I tested 32-bit x86 and it works).  But a bug
in both 32-bit ARM and aarch64 would be less likely.

Paolo

> , with repeating spaces
> as well. I didn't notice it before since in my case the
> ufd_version_check() in test-migration.c was failing so the migration tests
> were reporting success but were actually just getting skipped.
> 
