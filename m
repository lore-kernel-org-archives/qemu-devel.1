Received: from eggs.gnu.org ([2001:4830:134:3::10]:56782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dDqHS-00075s-QV
	for qemu-devel@nongnu.org; Thu, 25 May 2017 06:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dDqHO-00060A-Uz
	for qemu-devel@nongnu.org; Thu, 25 May 2017 06:46:10 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170524164631.GA8855@redhat.com>
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-12-berrange@redhat.com>
	<w517f1ntqko.fsf@maestria.local.igalia.com>
	<20170524164631.GA8855@redhat.com>
Date: Thu, 25 May 2017 12:46:03 +0200
Message-ID: <w51d1axrz84.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 11/18] qcow2: convert QCow2 to use
 QCryptoBlock for encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Wed 24 May 2017 06:46:31 PM CEST, Daniel P. Berrange wrote:

>> > +    case QCOW_CRYPT_AES:
>> > +        if (encryptfmt && !g_str_equal(encryptfmt, "aes")) {
>> > +            error_setg(errp,
>> > +                       "Header reported 'aes' encryption format but "
>> > +                       "options specify '%s'", encryptfmt);
>> > +            ret = -EINVAL;
>> > +            goto fail;
>> > +        }
>> 
>> ...and here you could break instead, the condition immediately after
>> the switch sets ret to -EINVAL and returns.
>
> In thi case I think its clearer to set it right here, rather than
> having to follow the code paths through & read the later logic

Ok, works for me! :)

Berto
