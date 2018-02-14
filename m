Received: from eggs.gnu.org ([2001:4830:134:3::10]:60923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eluNd-0006ZP-Kc
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eluNZ-0007he-MY
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:33:37 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:41542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eluNZ-0007hS-Gf
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:33:33 -0500
Received: by mail-wr0-f179.google.com with SMTP id q11so9824182wre.8
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 02:33:33 -0800 (PST)
References: <20180214001105.21508-1-mdroth@linux.vnet.ibm.com>
	<20180214085148.GD13644@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a2c5404e-7f1e-09c8-329f-1abb585070df@redhat.com>
Date: Wed, 14 Feb 2018 11:33:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180214085148.GD13644@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post documenting
 Spectre/Meltdown options for QEMU 2.11.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On 14/02/2018 09:51, Daniel P. Berrangé wrote:
>> +Please note that, as mentioned in the previous blog post, QEMU/KVM generally
>> +has the same requirements as other unpriviledged processes running on the
>> +host WRT Spectre/Meltdown mitigation.
>
> Is this actually still considered accurate wrt the host QEMU ? I was under
> the believe that life is more complicated for QEMU/KVM wrt Spectre and that
> it will require more protection than other unpriv processes on the host in
> some cases.

The plan is for KVM to ensure that QEMU can be treated as yet another
unprivileged process.  Anything else would require applying the same
care to all of QEMU's dependencies.

Paolo
