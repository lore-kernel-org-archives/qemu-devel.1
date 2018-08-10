Received: from eggs.gnu.org ([2001:4830:134:3::10]:39792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo4Tg-000772-9V
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo4Td-0000SU-3G
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:17:04 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:35905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fo4Tc-0000Rx-RK
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:17:01 -0400
Received: by mail-wr1-f50.google.com with SMTP id h9-v6so7830740wro.3
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 03:17:00 -0700 (PDT)
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-6-e.emanuelegiuseppe@gmail.com>
	<f5a3c33f-f459-806c-1465-3b5415a5ccc1@redhat.com>
	<141175f7-a38a-5236-cd63-70353870913a@redhat.com>
	<b17c18e1-e283-b65b-8f26-efae69be8119@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b825d311-8513-8925-8761-47a34c07cdd2@redhat.com>
Date: Fri, 10 Aug 2018 12:16:56 +0200
MIME-Version: 1.0
In-Reply-To: <b17c18e1-e283-b65b-8f26-efae69be8119@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/34] tests/qgraph: sdhci driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 09/08/2018 13:01, Laurent Vivier wrote:
>> No, there is only one libqgraph.  The same test (qos-test) can run for
>> both PCI and non-PCI machines, and will cull the unnecessary part of the
>> graph automatically simply because there is no path from a machine to a
>> PCI device.
> So, all libqgraph files should be added to check-qtest-generic-y?

Yes.

Paolo
