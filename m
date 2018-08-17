Received: from eggs.gnu.org ([2001:4830:134:3::10]:40111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fqidi-0003QR-2r
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fqidh-0005ku-9B
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:34:22 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fqidd-0005h3-5S
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:34:19 -0400
Received: by mail-wm0-x236.google.com with SMTP id o18-v6so8077569wmc.0
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 10:34:17 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-2-git-send-email-robert.hu@linux.intel.com>
	<f859ae02-015a-5ef8-66b4-f54a630d1f5f@redhat.com>
	<20180817155524.GF15372@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0df647b-ed1c-e497-10a7-f64a048b9f19@redhat.com>
Date: Fri, 17 Aug 2018 19:34:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180817155524.GF15372@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] x86: Data structure changes to
 support MSR based features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Robert Hoo <robert.hu@linux.intel.com>, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, robert.hu@intel.com, jingqi.liu@intel.com

On 17/08/2018 17:55, Eduardo Habkost wrote:
>> The names will be X86_CPU_FEATURE_WORD_TYPE_CPUID and
>> X86_CPU_FEATURE_WORD_TYPE_MSR.
> I wouldn't like to make this an external API unless really
> necessary.  I would rather deprecate the "feature-words" property
> because nobody ended up using it.

I think we should either remove it directly, or extend it to support MSR
features.  Deprecating and only supporting CPUID features is the worst
of both worlds...

Paolo
