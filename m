Received: from eggs.gnu.org ([2001:4830:134:3::10]:35208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1deSwu-00071v-6O
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 17:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1deSwp-0005k4-8p
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 17:19:00 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1deSwp-0005jT-27
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 17:18:55 -0400
Received: by mail-wm0-f44.google.com with SMTP id m85so54999661wma.1
	for <qemu-devel@nongnu.org>; Sun, 06 Aug 2017 14:18:52 -0700 (PDT)
References: <20170803090746.30532-1-marcandre.lureau@redhat.com>
	<1eca7ede-f103-ee90-1f9a-0fc44ef2b708@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cbf91ed4-a61a-78d7-e179-5826a335e4a9@redhat.com>
Date: Sun, 6 Aug 2017 23:18:46 +0200
MIME-Version: 1.0
In-Reply-To: <1eca7ede-f103-ee90-1f9a-0fc44ef2b708@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] build-sys: add --disable-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, cohuck@redhat.com, philippe.mathieu.daude@gmail.com, Alexander Graf <agraf@suse.de>, mst@redhat.com

On 05/08/2017 09:39, Thomas Huth wrote:
>> +CONFIG_VHOST_USER_SCSI=$(and $(CONFIG_VHOST_USER),$(CONFIG_LINUX))
> I have to say that I don't really like using $(and ...) in our makefiles
> like this. You rely on the fact that the config variables are either set
> to "y" or not set at all ... but if somebody ever tries to set
> CONFIG_VHOST_USER=n and CONFIG_LINUX=y for example (which sounds valid,
> too), this will break. Isn't there a better way of checking that both
> variables are set to "y" ?

$(call land, ...) does exactly this.

Paolo
