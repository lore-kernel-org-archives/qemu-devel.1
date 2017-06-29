Received: from eggs.gnu.org ([2001:4830:134:3::10]:40640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQXyv-00046K-AV
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQXyq-0004Jp-5w
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:51:33 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dQXyp-0004JY-Ut
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:51:28 -0400
Received: by mail-wr0-x231.google.com with SMTP id c11so188264037wrc.3
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 04:51:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170629080452.26470-1-famz@redhat.com>
	<20170629080452.26470-5-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a67102f-7be4-a4cb-9dad-ce6cdcb3b0a3@redhat.com>
Date: Thu, 29 Jun 2017 13:51:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170629080452.26470-5-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/7] qdev: Introduce DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>



On 29/06/2017 10:04, Fam Zheng wrote:
> +#define DEFINE_PROP_LINK(_name, _state, _field, _type, _check, _flags) {\
> +        .name = (_name),                                                \
> +        .info = &(qdev_prop_link),                                      \
> +        .offset = offsetof(_state, _field)                              \
> +            + type_check(Object *, typeof_field(_state, _field)),       \
> +        .link.check = _check,                                           \
> +        .link.flags = _flags,                                           \
> +        .link_type  = _type,                                            \
> +        }
> +

Still unsure about _check; qdev_prop_allow_set_link_before_realize is
mimicking the same behavior of any other qdev property, so it should be
always okay for DEFINE_PROP_LINK.

Paolo
