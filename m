Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA40C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9389D2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9389D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51931 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT3LC-0001iy-Rm
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 07:53:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT3KO-0001RH-0I
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT3KM-0006FR-9T
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:53:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hT3KM-0006Eq-1K
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:53:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00CF830833AF;
	Tue, 21 May 2019 11:53:05 +0000 (UTC)
Received: from redhat.com (ovpn-112-26.ams2.redhat.com [10.36.112.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BB5A78420;
	Tue, 21 May 2019 11:53:03 +0000 (UTC)
Date: Tue, 21 May 2019 12:52:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190521115259.GK25835@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
	<1557953433-19663-19-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1557953433-19663-19-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 21 May 2019 11:53:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 18/21] build: don't build hardware objects
 with linux-user
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 10:50:30PM +0200, Paolo Bonzini wrote:
> From: Laurent Vivier <lvivier@redhat.com>
> 
> Some objects are only needed for system emulation and tools.
> We can ignore them for the user mode case
> 
> Update tests to run accordingly: conditionally build some tests
> on CONFIG_BLOCK.
> 
> Some tests use components that are only built when softmmu or
> block tools are enabled, not for linux-user. So, if these components
> are not available, disable the tests.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Message-Id: <20190401141222.30034-6-lvivier@redhat.com>
> ---
>  Makefile               |  4 +++
>  Makefile.objs          | 14 +++++---
>  tests/Makefile.include | 90 +++++++++++++++++++++++++-------------------------
>  3 files changed, 58 insertions(+), 50 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1851f8c..155f066 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -87,6 +87,10 @@ endif
>  
>  include $(SRC_PATH)/rules.mak
>  
> +# notempy and lor are defined in rules.mak
> +CONFIG_TOOLS := $(call notempty,$(TOOLS))
> +CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))

IMHO calling this CONFIG_BLOCK is a really poor choice, as
the decision is completely unrelated to block modules. It
made really confused when trying to understand why all the
crypto or auth code had been made conditional on the block
drivers.  The block code is just one part of QEMU that
is used in tools & softmmu.

It would be better as CONFIG_SOFTMMU_TOOLS, or
CONFIG_NOT_USER, or something else.

> +trace-events-subdirs += crypto
> +ifeq ($(CONFIG_USER_ONLY),y)
> +trace-events-subdirs += linux-user
> +endif
> +ifeq ($(CONFIG_BLOCK),y)
>  trace-events-subdirs += authz
>  trace-events-subdirs += block
> -trace-events-subdirs += crypto
> +trace-events-subdirs += io
> +trace-events-subdirs += nbd
> +trace-events-subdirs += scsi
> +endif
>  ifeq ($(CONFIG_SOFTMMU),y)
>  trace-events-subdirs += chardev
>  trace-events-subdirs += audio
> @@ -178,12 +186,8 @@ trace-events-subdirs += net
>  trace-events-subdirs += ui
>  endif
>  trace-events-subdirs += hw/display
> -trace-events-subdirs += io
> -trace-events-subdirs += linux-user
> -trace-events-subdirs += nbd
>  trace-events-subdirs += qapi
>  trace-events-subdirs += qom
> -trace-events-subdirs += scsi
>  trace-events-subdirs += target/arm
>  trace-events-subdirs += target/hppa
>  trace-events-subdirs += target/i386
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index ad95a14..1865f6b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -45,7 +45,7 @@ SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
>  
>  check-unit-y += tests/check-qdict$(EXESUF)
>  check-unit-y += tests/check-block-qdict$(EXESUF)
> -check-unit-y += tests/test-char$(EXESUF)
> +check-unit-$(CONFIG_SOFTMMU) += tests/test-char$(EXESUF)
>  check-unit-y += tests/check-qnum$(EXESUF)
>  check-unit-y += tests/check-qstring$(EXESUF)
>  check-unit-y += tests/check-qlist$(EXESUF)
> @@ -61,21 +61,21 @@ check-unit-y += tests/test-string-input-visitor$(EXESUF)
>  check-unit-y += tests/test-string-output-visitor$(EXESUF)
>  check-unit-y += tests/test-qmp-event$(EXESUF)
>  check-unit-y += tests/test-opts-visitor$(EXESUF)
> -check-unit-y += tests/test-coroutine$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-coroutine$(EXESUF)
>  check-unit-y += tests/test-visitor-serialization$(EXESUF)
>  check-unit-y += tests/test-iov$(EXESUF)
> -check-unit-y += tests/test-aio$(EXESUF)
> -check-unit-y += tests/test-aio-multithread$(EXESUF)
> -check-unit-y += tests/test-throttle$(EXESUF)
> -check-unit-y += tests/test-thread-pool$(EXESUF)
> -check-unit-y += tests/test-hbitmap$(EXESUF)
> -check-unit-y += tests/test-bdrv-drain$(EXESUF)
> -check-unit-y += tests/test-bdrv-graph-mod$(EXESUF)
> -check-unit-y += tests/test-blockjob$(EXESUF)
> -check-unit-y += tests/test-blockjob-txn$(EXESUF)
> -check-unit-y += tests/test-block-backend$(EXESUF)
> -check-unit-y += tests/test-block-iothread$(EXESUF)
> -check-unit-y += tests/test-image-locking$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-aio$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-aio-multithread$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-throttle$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-thread-pool$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-hbitmap$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-bdrv-drain$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-bdrv-graph-mod$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-blockjob$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-blockjob-txn$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-block-backend$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-block-iothread$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-image-locking$(EXESUF)
>  check-unit-y += tests/test-x86-cpuid$(EXESUF)
>  # all code tested by test-x86-cpuid is inside topology.h
>  ifeq ($(CONFIG_SOFTMMU),y)
> @@ -101,40 +101,40 @@ check-unit-y += tests/check-qom-interface$(EXESUF)
>  check-unit-y += tests/check-qom-proplist$(EXESUF)
>  check-unit-y += tests/test-qemu-opts$(EXESUF)
>  check-unit-y += tests/test-keyval$(EXESUF)
> -check-unit-y += tests/test-write-threshold$(EXESUF)
> -check-unit-y += tests/test-crypto-hash$(EXESUF)
> -check-speed-y += tests/benchmark-crypto-hash$(EXESUF)
> -check-unit-y += tests/test-crypto-hmac$(EXESUF)
> -check-speed-y += tests/benchmark-crypto-hmac$(EXESUF)
> -check-unit-y += tests/test-crypto-cipher$(EXESUF)
> -check-speed-y += tests/benchmark-crypto-cipher$(EXESUF)
> -check-unit-y += tests/test-crypto-secret$(EXESUF)
> -check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlscredsx509$(EXESUF)
> -check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlssession$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-write-threshold$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-crypto-hash$(EXESUF)
> +check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-hash$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-crypto-hmac$(EXESUF)
> +check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-hmac$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-crypto-cipher$(EXESUF)
> +check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-cipher$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-crypto-secret$(EXESUF)
> +check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlscredsx509$(EXESUF)
> +check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlssession$(EXESUF)
>  ifneq (,$(findstring qemu-ga,$(TOOLS)))
>  check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
>  endif
>  check-unit-y += tests/test-timed-average$(EXESUF)
>  check-unit-$(CONFIG_INOTIFY1) += tests/test-util-filemonitor$(EXESUF)
>  check-unit-y += tests/test-util-sockets$(EXESUF)
> -check-unit-y += tests/test-authz-simple$(EXESUF)
> -check-unit-y += tests/test-authz-list$(EXESUF)
> -check-unit-y += tests/test-authz-listfile$(EXESUF)
> -check-unit-$(CONFIG_AUTH_PAM) += tests/test-authz-pam$(EXESUF)
> -check-unit-y += tests/test-io-task$(EXESUF)
> -check-unit-y += tests/test-io-channel-socket$(EXESUF)
> -check-unit-y += tests/test-io-channel-file$(EXESUF)
> -check-unit-$(CONFIG_GNUTLS) += tests/test-io-channel-tls$(EXESUF)
> -check-unit-y += tests/test-io-channel-command$(EXESUF)
> -check-unit-y += tests/test-io-channel-buffer$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-authz-simple$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-authz-list$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-authz-listfile$(EXESUF)
> +check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_AUTH_PAM)) += tests/test-authz-pam$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-io-task$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-socket$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-file$(EXESUF)
> +check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-io-channel-tls$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-command$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-buffer$(EXESUF)
>  check-unit-y += tests/test-base64$(EXESUF)
> -check-unit-$(if $(CONFIG_NETTLE),y,$(CONFIG_GCRYPT)) += tests/test-crypto-pbkdf$(EXESUF)
> -check-unit-y += tests/test-crypto-ivgen$(EXESUF)
> -check-unit-y += tests/test-crypto-afsplit$(EXESUF)
> -check-unit-y += tests/test-crypto-xts$(EXESUF)
> -check-unit-y += tests/test-crypto-block$(EXESUF)
> +check-unit-$(call land,$(CONFIG_BLOCK),$(if $(CONFIG_NETTLE),y,$(CONFIG_GCRYPT))) += tests/test-crypto-pbkdf$(EXESUF)
> +check-unit-$(CONFIG_BLOCK) += tests/test-crypto-ivgen$(EXESUF)
> +check-unit-$(CONFIG_BLOCK)  += tests/test-crypto-afsplit$(EXESUF)
> +check-unit-$(CONFIG_BLOCK)  += tests/test-crypto-xts$(EXESUF)
> +check-unit-$(CONFIG_BLOCK)  += tests/test-crypto-block$(EXESUF)
>  check-unit-y += tests/test-logging$(EXESUF)
> -check-unit-$(CONFIG_REPLICATION) += tests/test-replication$(EXESUF)
> +check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_REPLICATION)) += tests/test-replication$(EXESUF)
>  check-unit-y += tests/test-bufferiszero$(EXESUF)
>  check-unit-y += tests/test-uuid$(EXESUF)
>  check-unit-y += tests/ptimer-test$(EXESUF)
> @@ -496,11 +496,11 @@ test-qapi-obj-y = tests/test-qapi-types.o \
>  	tests/test-qapi-visit-sub-sub-module.o \
>  	tests/test-qapi-introspect.o \
>  	$(test-qom-obj-y)
> -benchmark-crypto-obj-y = $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj-y)
> -test-crypto-obj-y = $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj-y)
> -test-io-obj-y = $(io-obj-y) $(test-crypto-obj-y)
> -test-authz-obj-y = $(test-qom-obj-y) $(authz-obj-y)
> -test-block-obj-y = $(block-obj-y) $(test-io-obj-y) tests/iothread.o
> +benchmark-crypto-obj-$(CONFIG_BLOCK) = $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj-y)
> +test-crypto-obj-$(CONFIG_BLOCK) = $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj-y)
> +test-io-obj-$(CONFIG_BLOCK) = $(io-obj-y) $(test-crypto-obj-y)
> +test-authz-obj-$(CONFIG_BLOCK) = $(test-qom-obj-y) $(authz-obj-y)
> +test-block-obj-$(CONFIG_BLOCK) = $(block-obj-y) $(test-io-obj-y) tests/iothread.o
>  
>  tests/check-qnum$(EXESUF): tests/check-qnum.o $(test-util-obj-y)
>  tests/check-qstring$(EXESUF): tests/check-qstring.o $(test-util-obj-y)
> -- 
> 1.8.3.1
> 
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

