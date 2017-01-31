Received: from eggs.gnu.org ([2001:4830:134:3::10]:45792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cYZQn-0004aH-0d
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cYZQi-0002um-3q
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:29:13 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cYZQi-0002ug-0P
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:29:08 -0500
Received: by mail-qk0-x242.google.com with SMTP id i34so21273238qkh.3
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 06:29:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
	<20170120164322.21851-8-pbonzini@redhat.com>
	<20170130155044.GP2118@stefanha-x1.localdomain>
	<70a0127e-b698-9530-ddec-466c4a635f0c@redhat.com>
	<20170131135021.GI18804@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad2965a1-46a0-2b0f-eeea-6b89bb9daf5f@redhat.com>
Date: Tue, 31 Jan 2017 09:29:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170131135021.GI18804@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/17] nbd: convert to use qio_channel_yield
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, famz@redhat.com, qemu-devel@nongnu.org



On 31/01/2017 08:50, Stefan Hajnoczi wrote:
>> I'm not sure a
>> comment in the NBD driver is the best place, because similar logic will
>> appear soon in other networked block drivers.
> Maybe add a new function that just does these two calls.  I don't have a
> good name for it.

For now I'll add a comment here.  I checked my final branch and the
idiom is not as frequent as I thought.

Paolo
