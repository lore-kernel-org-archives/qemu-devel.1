Received: from eggs.gnu.org ([209.51.188.92]:37955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtvWI-0006lW-W0
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtvWH-0004qF-04
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:28:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gtvWG-0004mI-Mi
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:28:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 792FBC049E20
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 14:18:34 +0000 (UTC)
References: <871s4chvb2.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e429792-cbea-c96c-ad48-7f5bdd7ef781@redhat.com>
Date: Wed, 13 Feb 2019 15:18:31 +0100
MIME-Version: 1.0
In-Reply-To: <871s4chvb2.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Seeking QEMU makefile advice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 13/02/19 10:49, Markus Armbruster wrote:
> * Define QAPI_COMMON_MODULES, QAPI_TARGET_MODULES and QAPI_MODULES in
>   Makefile.obj
> 
> * Add to util-obj-y in Makefile.obj
> 
> * Add to obj-y in Makefile.target

Why can't both be in Makefile.objs, or in qapi/Makefile.objs?

Paolo

>   No go, because QAPI_TARGET_MODULES is blank there.  To make progress,
>   I duplicated its definition there, marked FIXME.
> 
> Message-Id: <20190206181725.14337-8-armbru@redhat.com>
> https://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg01652.html
> Diff appended for your convenience.
> 
> I've since realized QAPI_TARGET_MODULES is blank there because it only
> gets defined further down, via include $(SRC_PATH)/Makefile.objs.
> 
> This leads me to my problem:
> 
> * On the one hand, I want to add to obj-y after the include defines
>   QAPI_TARGET_MODULES.
> 
> * On the other hand, I need to be done with adding to obj-y before the
>   all-obj-y := $(obj-y) line.
> 
> Can't satisfy both.  Any ideas on how to better distribute the work
> between the makefiles?
